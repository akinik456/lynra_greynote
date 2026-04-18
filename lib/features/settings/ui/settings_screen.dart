import 'dart:convert';
import 'dart:io';
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
            onTap: exportPlaceholder,
          ),
          _Item(
  title: AppLocalizations.of(context)!.importData,
  onTap: () async {
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
      final data = jsonDecode(content);

      final vaultRows = List<Map<String, dynamic>>.from(data["vault"] ?? []);
      final collectionRows = List<Map<String, dynamic>>.from(data["collections"] ?? []);

      final db = DatabaseHelper.instance.getDb();

      // 🔑 mevcut cihazın masterKey’ini al
      final mk = await _getUnwrappedMasterKey();
      if (mk == null) throw Exception("MasterKey alınamadı");

      // 📂 mevcut collection’ları al (isim → id map)
      final existingCollections = await db.query('collections');
      final Map<String, String> nameToId = {
  for (final c in existingCollections)
    (c['name'] ?? 'Unknown').toString():
        (c['id'] ?? '').toString(),
};

      // 🧩 export collection id → yeni cihaz collection id map
      final Map<String, String> importColIdMap = {};

      for (final col in collectionRows) {
        final name = (col['name'] ?? 'Imported').toString();

        if (nameToId.containsKey(name)) {
          // varsa mevcut id’ye bağla
          importColIdMap[col['id']] = nameToId[name]!;
        } else {
          // yoksa yeni oluştur
          final newId = const Uuid().v4();
          final now = DateTime.now().millisecondsSinceEpoch;

          await db.insert('collections', {
            'id': newId,
            'name': name,
            'createdAt': now,
            'updatedAt': now,
          });

          nameToId[name] = newId;
          importColIdMap[col['id']] = newId;
        }
      }

      // 📦 vault kayıtlarını işle
      for (final row in vaultRows) {
        try {
          final encryptedPayload = row['payload'] as String;

          // 🔓 eski payload’ı çöz (export’un geldiği cihazın key’iyle)
          final plain = await CryptoHelper.decrypt(encryptedPayload, mk);

          // 🔐 yeni cihaz için tekrar şifrele
          final newPayload = await CryptoHelper.encrypt(plain, mk);

          final newId = const Uuid().v4();
          final now = DateTime.now().millisecondsSinceEpoch;

          final oldColId = row['collectionId'];
          final newColId = importColIdMap[oldColId] ?? 'default';

          await db.insert('vault', {
            'id': newId,
            'payload': newPayload,
            'createdAt': now,
            'updatedAt': now,
            'isFavorite': row['isFavorite'] ?? 0,
            'collectionId': newColId,
          });
        } catch (e) {
          print("Import item skip (decrypt fail): $e");
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.importCompleted)),
      );

      Navigator.pop(context, true); // 🔄 refresh trigger

    } finally {
      LynraApp.of(context).setSuspendAutoLock(false);
    }
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

  Future<void> exportPlaceholder() async {
    final db = DatabaseHelper.instance.getDb();
    final rows = await db.query('vault');
    final collectionRows = await db.query('collections');

    final jsonString = jsonEncode({
      "vault": rows,
      "collections": collectionRows,
    });

    await FileSaver.instance.saveAs(
      name: "lynra_backup",
      bytes: utf8.encode(jsonString),
      ext: "json",
      mimeType: MimeType.json,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.exportComingNext)),
    );
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