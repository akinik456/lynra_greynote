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
    final currentLocale = Localizations.localeOf(context);

    final languages = <Map<String, dynamic>>[
      {"label": "English - English", "search": "English", "locale": const Locale('en')},
      {"label": "Türkçe - Turkish", "search": "Turkish Türkçe", "locale": const Locale('tr')},
      {"label": "Español - Spanish", "search": "Spanish Español", "locale": const Locale('es')},
      {"label": "Deutsch - German", "search": "German Deutsch", "locale": const Locale('de')},
      {"label": "Français - French", "search": "French Français", "locale": const Locale('fr')},
      {"label": "Italiano - Italian", "search": "Italian Italiano", "locale": const Locale('it')},
      {"label": "Português (Brasil) - Portuguese", "search": "Portuguese Brasil Português", "locale": const Locale('pt', 'BR')},
      {"label": "हिन्दी - Hindi", "search": "Hindi हिन्दी", "locale": const Locale('hi')},
      {"label": "한국어 - Korean", "search": "Korean 한국어", "locale": const Locale('ko')},
      {"label": "日本語 - Japanese", "search": "Japanese  日本語", "locale": const Locale('ja')},
      {"label": "简体中文 - Chinese", "search": "Chinese 简体中文", "locale": const Locale('zh')},
      {"label": "العربية - Arabic", "search": "Arabic العربية", "locale": const Locale('ar')},
      {"label": "Русский - Russian", "search": "Russian Русский", "locale": const Locale('ru')},
      {"label": "Bahasa Indonesia - Indonesian", "search": "Indonesian Bahasa Indonesia", "locale": const Locale('id')},
      {"label": "Tiếng Việt - Vietnamese", "search": "Vietnamese Tiếng Việt", "locale": const Locale('vi')},
      {"label": "ไทย - Thai", "search": "Thai ไทย", "locale": const Locale('th')},
      {"label": "Nederlands - Dutch", "search": "Dutch Nederlands", "locale": const Locale('nl')},
      {"label": "Polski - Polish", "search": "Polish Polski", "locale": const Locale('pl')},
      {"label": "Svenska - Swedish", "search": "Swedish Svenska", "locale": const Locale('sv')},
    ];

    bool isSameLocale(Locale a, Locale b) {
      return a.languageCode == b.languageCode &&
          (a.countryCode ?? '') == (b.countryCode ?? '');
    }

    final selected = languages.where((item) {
      final locale = item["locale"] as Locale;
      return isSameLocale(locale, currentLocale);
    }).toList();

    final others = languages.where((item) {
      final locale = item["locale"] as Locale;
      return !isSameLocale(locale, currentLocale);
    }).toList()
      ..sort((a, b) => (a["label"] as String).compareTo(b["label"] as String));

    final sortedLanguages = [...selected, ...others];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF020617),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        String query = '';

        return StatefulBuilder(
          builder: (context, setModalState) {
            final filtered = sortedLanguages.where((item) {
              if (query.trim().isEmpty) return true;
              final q = query.toLowerCase();
              final label = (item["label"] as String).toLowerCase();
              final search = (item["search"] as String).toLowerCase();
              return label.contains(q) || search.contains(q);
            }).toList();

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  12,
                  16,
                  16 + MediaQuery.of(sheetContext).viewInsets.bottom,
                ),
                child: SizedBox(
                  height: MediaQuery.of(sheetContext).size.height * 0.78,
                  child: Column(
                    children: [
                      Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.selectLanguage,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setModalState(() {
                              query = value;
                            });
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Search language...",
                            hintStyle: TextStyle(color: Colors.white54),
                            prefixIcon: Icon(Icons.search, color: Colors.white54),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: ListView.separated(
                            itemCount: filtered.length,
                            separatorBuilder: (_, __) =>
                                const Divider(height: 1, color: Colors.white10),
                            itemBuilder: (context, index) {
                              final item = filtered[index];
                              final locale = item["locale"] as Locale;
                              final label = item["label"] as String;
                              final isSelected =
                                  isSameLocale(locale, currentLocale);

                              return Material(
                                color: isSelected
                                    ? const Color(0xFF0F172A)
                                    : Colors.transparent,
                                child: ListTile(
                                  minTileHeight: 56,
                                  title: Text(
                                    label,
                                    textAlign: locale.languageCode == 'ar'
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    style: TextStyle(
                                      color: isSelected
                                          ? const Color(0xFF22D3EE)
                                          : Colors.white,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                                  ),
                                  trailing: isSelected
                                      ? const Icon(
                                          Icons.check,
                                          color: Color(0xFF22D3EE),
                                        )
                                      : null,
                                  onTap: () {
                                    LynraApp.of(context).setLocale(locale);
                                    Navigator.pop(sheetContext);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
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
          title: Text(AppLocalizations.of(context)!.exportPin),
          content: TextField(
            controller: exportPinController,
            keyboardType: TextInputType.number,
            maxLength: 5,
            obscureText: true,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.enterPinHint,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                final pin = exportPinController.text.trim();
                if (pin.length == 5 && RegExp(r'^\d{5}$').hasMatch(pin)) {
                  Navigator.pop(context, pin);
                }
              },
              child: Text(AppLocalizations.of(context)!.export.toUpperCase()),
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
			AppLocalizations.of(context)!.myVault
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
      SnackBar(
  content: Text(AppLocalizations.of(context)!.exportCompleted),
),
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
          title: Text(AppLocalizations.of(context)!.importPin),
          content: TextField(
            controller: pinController,
            keyboardType: TextInputType.number,
            maxLength: 5,
            obscureText: true,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.enterPinHint,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                final pin = pinController.text.trim();
                if (pin.length == 5 && RegExp(r'^\d{5}$').hasMatch(pin)) {
                  Navigator.pop(context, pin);
                }
              },
              child: Text(AppLocalizations.of(context)!.import.toUpperCase()),
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
        final rawName = (item['collectionName'] ?? '').toString();

final collectionName =
    rawName == 'My Vault' || rawName.isEmpty
        ? AppLocalizations.of(context)!.myVault
        : rawName;

        String collectionId;

        if (collectionName.isEmpty || collectionName == 'My Vault') {
  collectionId = 'default';
} else if (nameToId.containsKey(collectionName)) {
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
  SnackBar(
    content: Text(AppLocalizations.of(context)!.importCompleted),
  ),
);

    Navigator.pop(context, true); // 🔄 refresh trigger
  } catch (e) {
    print("Import error: $e");

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(AppLocalizations.of(context)!.importFailed),
  ),
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
			fontSize: 15,
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