import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'security_screen.dart';
import '../../vault/data/vault_repository.dart';
import 'vault_word_screen.dart';
import '../../../core/db/database_helper.dart';
import '../../../l10n/app_localizations.dart';
import '../../../main.dart';
import '../../../core/db/database_helper.dart';
import '../../auth/data/auth_storage.dart';
import '../../../core/security/crypto_helper.dart';

class SettingsScreen extends StatefulWidget {
  final String vaultKey;
  const SettingsScreen({
    super.key,
    required this.vaultKey,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final repo = VaultRepository();

  static const Color _bgColor = Color(0xFF020617);
  static const Color _cardColor = Color(0xFF0F172A);
  static const Color _primary = Color(0xFF22D3EE);
  static const Color _textPrimary = Color(0xFFE2E8F0);
  static const Color _textSecondary = Color(0xFF94A3B8);

Future<String?> _getUnwrappedMasterKey() async {
  final wrappedMK = await AuthStorage.getWrappedMasterKey();

  if (wrappedMK == null) return null;

  try {
    return await CryptoHelper.unwrapMasterKey(
      wrappedMKBase64: wrappedMK,
      password: widget.vaultKey,
    );
  } catch (e) {
    print("unwrap error: $e");
    return null;
  }
}  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _bgColor,
        surfaceTintColor: _bgColor,
        elevation: 0,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.settings,
          style: TextStyle(
            color: _textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Item(
            title: AppLocalizations.of(context)!.security,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SecurityScreen(),
                ),
              );
            },
          ),
          _Item(
            title: AppLocalizations.of(context)!.vaultWord,
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VaultWordScreen(),
                ),
              );

              if (result == true) {
                setState(() {});
              }
            },
          ),  
          _Item(
            title: AppLocalizations.of(context)!.exportData,
            onTap: () async {
  await exportBackupBlob();
},
          ),
          _Item(
  title: AppLocalizations.of(context)!.importData,
  onTap: () async {
    await importBackupBlob();
  },
),
		  _Item(
  title: AppLocalizations.of(context)!.language,
  onTap: () {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.selectLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("English"),
                onTap: () {
                  LynraApp.of(context).setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Türkçe"),
                onTap: () {
                  LynraApp.of(context).setLocale(const Locale('tr'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  },
),
        ],
      ),
    );
  }
  
Future<void> exportBackupBlob() async {
  LynraApp.of(context).setSuspendAutoLock(true);

  try {
    final exportPinController = TextEditingController();

    final exportPin = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Export PIN'),
          content: TextField(
            controller: exportPinController,
            keyboardType: TextInputType.number,
            maxLength: 5,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Enter 5-digit PIN',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                final pin = exportPinController.text.trim();
                if (pin.length == 5 && RegExp(r'^\d{5}$').hasMatch(pin)) {
                  Navigator.pop(context, pin);
                }
              },
              child: const Text('EXPORT'),
            ),
          ],
        );
      },
    );

    if (exportPin == null) return;

    final db = DatabaseHelper.instance.getDb();
    final mk = await _getUnwrappedMasterKey();
    if (mk == null) throw Exception('MasterKey alınamadı');

    final vaultRowsRaw = await db.query('vault');
    final collectionRowsRaw = await db.query('collections');

    final collectionIdToName = {
      for (final c in collectionRowsRaw)
        (c['id'] as String): (c['name'] as String),
    };

    final List<Map<String, dynamic>> portableVault = [];

    for (final row in vaultRowsRaw) {
      final encryptedPayload = row['payload'] as String;
      final plainPayload = await CryptoHelper.decrypt(encryptedPayload, mk);
      final payloadMap = jsonDecode(plainPayload) as Map<String, dynamic>;

      portableVault.add({
        'payloadData': payloadMap,
        'createdAt': row['createdAt'],
        'updatedAt': row['updatedAt'],
        'isFavorite': row['isFavorite'],
        'collectionName':
            collectionIdToName[(row['collectionId'] ?? 'default').toString()] ??
            'My Vault',
      });
    }

    final portableJson = jsonEncode({
      'vault': portableVault,
    });

    final backupFileJson = await CryptoHelper.encryptBackupBlob(
      plainJson: portableJson,
      pattern: widget.vaultKey,
      exportPin: exportPin,
    );

    await FileSaver.instance.saveAs(
      name: 'lynra_backup',
      bytes: Uint8List.fromList(
        utf8.encode(jsonEncode(backupFileJson)),
      ),
      ext: 'json',
      mimeType: MimeType.json,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export completed')),
    );
  } finally {
    LynraApp.of(context).setSuspendAutoLock(false);
  }
}  
Future<void> importBackupBlob() async {
  LynraApp.of(context).setSuspendAutoLock(true);

  try {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null) return;

    final path = result.files.single.path!;
    final file = File(path);
    final content = await file.readAsString();
    final backupJson = jsonDecode(content);

    // 🔐 PIN sor
    final pinController = TextEditingController();

    final exportPin = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Import PIN'),
          content: TextField(
            controller: pinController,
            keyboardType: TextInputType.number,
            maxLength: 5,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Enter 5-digit PIN',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                final pin = pinController.text.trim();
                if (pin.length == 5 && RegExp(r'^\d{5}$').hasMatch(pin)) {
                  Navigator.pop(context, pin);
                }
              },
              child: const Text('IMPORT'),
            ),
          ],
        );
      },
    );

    if (exportPin == null) return;

    // 🔓 blob çöz
    final decryptedJsonString = await CryptoHelper.decryptBackupBlob(
      backupJson: backupJson,
      pattern: widget.vaultKey,
      exportPin: exportPin,
    );

    final data = jsonDecode(decryptedJsonString);
    final vaultRows = List<Map<String, dynamic>>.from(data["vault"] ?? []);

    final db = DatabaseHelper.instance.getDb();
    final mk = await _getUnwrappedMasterKey();
    if (mk == null) throw Exception("MasterKey alınamadı");

    // 📂 mevcut collection’ları al
    final existingCollections = await db.query('collections');
    final Map<String, String> nameToId = {
      for (final c in existingCollections)
        (c['name'] as String): (c['id'] as String),
    };

    for (final item in vaultRows) {
      try {
        final collectionName =
            (item['collectionName'] ?? 'My Vault').toString();

        String collectionId;

        if (nameToId.containsKey(collectionName)) {
          collectionId = nameToId[collectionName]!;
        } else {
          collectionId = const Uuid().v4();

          final now = DateTime.now().millisecondsSinceEpoch;

          await db.insert('collections', {
            'id': collectionId,
            'name': collectionName,
            'createdAt': now,
            'updatedAt': now,
          });

          nameToId[collectionName] = collectionId;
        }

        // 🔐 yeniden encrypt
        final payloadMap = Map<String, dynamic>.from(item['payloadData'] ?? {});

        final newPayload = await CryptoHelper.encrypt(
          jsonEncode(payloadMap),
          mk,
        );

        final newId = const Uuid().v4();
        final now = DateTime.now().millisecondsSinceEpoch;

        await db.insert('vault', {
          'id': newId,
          'payload': newPayload,
          'createdAt': now,
          'updatedAt': now,
          'isFavorite': item['isFavorite'] ?? 0,
          'collectionId': collectionId,
        });
      } catch (e) {
        print("Import skip: $e");
      }
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Import completed')),
    );

    Navigator.pop(context, true); // 🔄 refresh trigger
  } catch (e) {
    print("Import error: $e");

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Import failed')),
    );
  } finally {
    LynraApp.of(context).setSuspendAutoLock(false);
  }
}
}

class _Item extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _Item({
    required this.title,
    required this.onTap,
  });

  static const Color _cardColor = Color(0xFF0F172A);
  static const Color _primary = Color(0xFF22D3EE);
  static const Color _textPrimary = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: _textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: _primary,
        ),
        onTap: onTap,
      ),
    );
  }
}