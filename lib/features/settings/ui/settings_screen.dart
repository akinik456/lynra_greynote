import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:cryptography/cryptography.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'security_screen.dart';
import '../../vault/data/vault_repository.dart';
import 'vault_word_screen.dart';
import '../../../core/db/database_helper.dart';
import '../../../l10n/app_localizations.dart';
import '../../../main.dart';
import '../../../core/db/database_helper.dart';
import '../../auth/data/auth_storage.dart';
import '../../../core/security/crypto_helper.dart';
import '../../../core/attachments/attachment_service.dart';
import '../../../core/theme/app_colors.dart';


class SettingsScreen extends StatefulWidget {
  final String vaultKey;
	final SecretKey payloadKey;
	final String collectionId;
	
  const SettingsScreen({
    super.key,
    required this.vaultKey,
		required this.payloadKey,
		required this.collectionId,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final repo = VaultRepository();

  static const Color _primary = AppColors.accent;
		
	
Future<String?> _getUnwrappedMasterKey() async {
  final wrappedMK = await AuthStorage.getWrappedMasterKey();

  if (wrappedMK == null) return null;

  try {
    return await CryptoHelper.unwrapMasterKey(
      wrappedMKBase64: wrappedMK,
      password: widget.vaultKey,
    );
  } catch (e) {
    return null;
  }
}  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.settings,
          style: TextStyle(
            color: AppColors.textPrimary,
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
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        Widget option({
          required String label,
          required VoidCallback onTap,
        }) {
          return InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                option(
                  label: AppLocalizations.of(context)!.exportBackup,
                  onTap: () async {
                    Navigator.pop(context);
                    await exportBackupBlob();
                  },
                ),
                const SizedBox(height: 10),
                option(
                  label: AppLocalizations.of(context)!.exportText,
                  onTap: () async {
                    Navigator.pop(context);
                    exportTxt();
                  },
                ),
								const SizedBox(height: 10),
                option(
                  label: AppLocalizations.of(context)!.exportCSV,
                  onTap: () async {
                    Navigator.pop(context);
                    exportCSV();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  },
),

_Item(
  title: AppLocalizations.of(context)!.importData,
  onTap: () async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        Widget option({
          required String label,
          required VoidCallback onTap,
        }) {
          return InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                option(
                  label: AppLocalizations.of(context)!.importBackup,
                  onTap: () async {
                    Navigator.pop(context);
                    await importBackupBlob();
                  },
                ),
                const SizedBox(height: 10),
                option(
                  label: AppLocalizations.of(context)!.importText,
                  onTap: () async {
                    Navigator.pop(context);
                    await importTxt(
											payloadKey: widget.payloadKey,
											collectionId: widget.collectionId,
										);
                  },
                ),
								const SizedBox(height: 10),
                option(
                  label: AppLocalizations.of(context)!.importCSV,
                  onTap: () async {
                    Navigator.pop(context);
                    await importCsv(
											payloadKey: widget.payloadKey,
											collectionId: widget.collectionId,
										);
                  },
                ),
								
                const SizedBox(height: 10),
                option(
  label: AppLocalizations.of(context)!.downloadTemplate,
  onTap: () async {
    Navigator.pop(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        Widget option2({
          required String label,
          required VoidCallback onTap,
        }) {
          return InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                option2(
                  label: AppLocalizations.of(context)!.textTemplate,
                  onTap: () async {
                    Navigator.pop(context);
                    await downloadTxtTemplate();
                  },
                ),
                const SizedBox(height: 10),
                option2(
                  label: AppLocalizations.of(context)!.csvTemplate,
                  onTap: () async {
                    Navigator.pop(context);
                    await downloadCsvTemplate();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  },
),
              ],
            ),
          ),
        );
      },
    );
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
      backgroundColor: AppColors.background,
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
                          color: Colors.white.withOpacity(AppOpacity.subtle),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.selectLanguage,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withOpacity(AppOpacity.subtle)),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setModalState(() {
                              query = value;
                            });
                          },
                          style: const TextStyle(color: AppColors.white),
                          decoration: InputDecoration(
                            hintText: "Search language...",
                            hintStyle: TextStyle(color: Colors.white.withOpacity(AppOpacity.secondary)),
                            prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(AppOpacity.secondary)),
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
                                Divider(height: 1, color: Colors.white.withOpacity(AppOpacity.subtle)),
                            itemBuilder: (context, index) {
                              final item = filtered[index];
                              final locale = item["locale"] as Locale;
                              final label = item["label"] as String;
                              final isSelected =
                                  isSameLocale(locale, currentLocale);

                              return Material(
                                color: isSelected
                                    ? AppColors.surface
                                    : AppColors.transparent,
                                child: ListTile(
                                  minTileHeight: 56,
                                  title: Text(
                                    label,
                                    textAlign: locale.languageCode == 'ar'
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    style: TextStyle(
                                      color: isSelected
                                          ? AppColors.accent
                                          : AppColors.white,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w600,
                                    ),
                                  ),
                                  trailing: isSelected
                                      ? const Icon(
                                          Icons.check,
                                          color: AppColors.accent,
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
					_Item(
						title: AppLocalizations.of(context)!.securityManifesto,
						onTap: () {
							Navigator.push(
								context,
								MaterialPageRoute(
									builder: (_) => const SecurityManifestoScreen(),
								),
							);
						},
					),
					
					_Item(
	title: AppLocalizations.of(context)!.usageGuide,
	onTap: () {
		showDialog(
			context: context,
			builder: (context) {
				return AlertDialog(
					backgroundColor: AppColors.surface,
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(24),
					),
					title: Text(
						AppLocalizations.of(context)!.usageGuide,
						style: const TextStyle(
							color: AppColors.textPrimary,
							fontWeight: FontWeight.w700,
						),
					),
					content: SingleChildScrollView(
						child: Text(
							AppLocalizations.of(context)!.usageGuideText,
							style: const TextStyle(
								color: AppColors.textSecondary,
								height: 1.5,
							),
						),
					),
					actions: [
						TextButton(
							onPressed: () => Navigator.pop(context),
							child: Text(
								AppLocalizations.of(context)!.close,
								style: const TextStyle(
									color: AppColors.textPrimary,
								),
							),
						),
					],
				);
			},
		);
	},
),
					
					_Item(
  title: AppLocalizations.of(context)!.rateOnPlayStore,//"Rate on Play Store",
  onTap: () async {
    final Uri url = Uri.parse(
													'https://play.google.com/store/apps/details?id=com.lynra.greynote', 
    );

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  },
),
					_Item(
						title: AppLocalizations.of(context)!.feedback,
						onTap: () async {
							await openFeedback();
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
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.exportPin,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: exportPinController,
              keyboardType: TextInputType.number,
              maxLength: 5,
              obscureText: true,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.enterPinHint,
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.background,
                counterText: "",
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
						const SizedBox(height: 10),
						Text(
							AppLocalizations.of(context)!.backupPatternWarning,
							textAlign: TextAlign.center,
							style: const TextStyle(
								color: AppColors.textSecondary,
								fontSize: 12,
								height: 1.4,
							),
						),
						const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
											final pin = exportPinController.text.trim();

											if (pin.length == 5 && RegExp(r'^\d{5}$').hasMatch(pin)) {
												FocusScope.of(context).unfocus();        // keyboard kapat
												await Future.delayed(const Duration(milliseconds: 120));

												if (context.mounted) {
													Navigator.pop(context, pin);
												}
											}
										},
                    child: Text(AppLocalizations.of(context)!.export.toUpperCase()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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

    final Map<String, String> attachments = {};
final attachmentService = AttachmentService();

for (final row in vaultRowsRaw) {
  final itemId = row['id'] as String;

  final encryptedPayload = row['payload'] as String;
  final plainPayload = await CryptoHelper.decryptWithKey(
  encryptedPayload,
  widget.payloadKey,
);
  final payloadMap = jsonDecode(plainPayload) as Map<String, dynamic>;

  portableVault.add({
    'payloadData': payloadMap,
    'createdAt': row['createdAt'],
    'updatedAt': row['updatedAt'],
    'isFavorite': row['isFavorite'],
    'collectionName':
        collectionIdToName[(row['collectionId'] ?? 'default').toString()] ??
            AppLocalizations.of(context)!.myVault,
  });

  final hasAttachment = (row['hasAttachment'] ?? 0) == 1;

  if (hasAttachment) {
    final path = await attachmentService.getAttachmentPath(itemId);
    final file = File(path);

    if (await file.exists()) {
      final encryptedAttachment = await file.readAsString();

		final decryptedAttachment = await CryptoHelper.decryptWithKey(
			encryptedAttachment,
			widget.payloadKey,
		);

		attachments[itemId] = decryptedAttachment;
		//print("EXPORT ATTACHMENT START: ${decryptedAttachment.substring(0, 20)}");
    }
  }
}
    final portableJson = jsonEncode({
      'vault': portableVault,
			'attachments': attachments,
    });

    final backupFileJson = await CryptoHelper.encryptBackupBlob(
      plainJson: portableJson,
      pattern: widget.vaultKey,
      exportPin: exportPin,
    );

    final savedPath = await FileSaver.instance.saveAs(
			name: 'lynra_backup',
			bytes: Uint8List.fromList(
				utf8.encode(jsonEncode(backupFileJson)),
			),
			ext: 'json',
			mimeType: MimeType.json,
		);

		if (!mounted) return;

		if (savedPath == null) {
			return;
		}

		ScaffoldMessenger.of(context).showSnackBar(
			SnackBar(
				content: Text(AppLocalizations.of(context)!.exportCompleted),
			),
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

    final file = File(result.files.single.path!);
    final content = await file.readAsString();
    final backupJson = jsonDecode(content);

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

    final decryptedJsonString = await CryptoHelper.decryptBackupBlob(
      backupJson: backupJson,
      pattern: widget.vaultKey,
      exportPin: exportPin,
    );

    final data = jsonDecode(decryptedJsonString) as Map<String, dynamic>;
    final vaultRows = List<Map<String, dynamic>>.from(data["vault"] ?? []);
    final attachments = data["attachments"] as Map<String, dynamic>?;

    final db = DatabaseHelper.instance.getDb();

    final existingCollections = await db.query('collections');
    final Map<String, String> nameToId = {
      for (final c in existingCollections)
        (c['name'] as String): (c['id'] as String),
    };

    final attachmentService = AttachmentService();

    for (final item in vaultRows) {
      try {
        final rawName = (item['collectionName'] ?? '').toString();

        final collectionName =
            rawName == 'My Vault' || rawName.isEmpty
                ? AppLocalizations.of(context)!.myVault
                : rawName;

        String collectionId;

        if (collectionName.isEmpty ||
            collectionName == 'My Vault' ||
            collectionName == AppLocalizations.of(context)!.myVault) {
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

        final payloadMap =
            Map<String, dynamic>.from(item['payloadData'] ?? {});

        final importedId = (payloadMap['id'] ?? '').toString().isNotEmpty
            ? payloadMap['id'].toString()
            : const Uuid().v4();

        payloadMap['id'] = importedId;
        payloadMap['collectionId'] = collectionId;

        final now = DateTime.now().millisecondsSinceEpoch;

        final hasAttachment =
            attachments != null && attachments.containsKey(importedId);

        final newPayload = await CryptoHelper.encryptWithKey(
  jsonEncode(payloadMap),
  widget.payloadKey,
);

await db.insert('vault', {
  'id': importedId,
  'payload': newPayload,
  'createdAt': item['createdAt'] ?? now,
  'updatedAt': item['updatedAt'] ?? now,
  'isFavorite': item['isFavorite'] ?? 0,
  'collectionId': collectionId,
  'hasAttachment': hasAttachment ? 1 : 0,
});

if (hasAttachment) {
  final attachmentContent = attachments[importedId] as String;

  final encryptedAttachment = await CryptoHelper.encryptWithKey(
    attachmentContent,
    widget.payloadKey,
  );
//print("IMPORT ATTACHMENT START: ${attachmentContent.substring(0, 20)}");
  final attachmentPath =
      await attachmentService.getAttachmentPath(importedId);

  await File(attachmentPath).writeAsString(
    encryptedAttachment,
    flush: true,
  );
}
      } catch (e) {
        // skip broken imported item
      }
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.importCompleted),
      ),
    );
    Navigator.pop(context, true);
  } catch (e) {
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
Future<void> exportTxt() async {
	LynraApp.of(context).setSuspendAutoLock(true);
	int skippedPattern = 0;
	try{
  final items = await repo.getItems(
    payloadKey: widget.payloadKey,
    collectionId: widget.collectionId,
  );
  final buffer = StringBuffer();
  for (final item in items) {
	if (item.type == "pattern") {
  skippedPattern++;
  continue;
}
    buffer.writeln('Title: ${item.title}');
    buffer.writeln('Username: ${item.username}');
    buffer.writeln('Password: ${item.password}');
    buffer.writeln('IBAN: ${item.iban}');
    buffer.writeln('Note: ${item.note}');
    buffer.writeln('');
    buffer.writeln('---');
    buffer.writeln('');
  }
  final path = await FileSaver.instance.saveAs(
    name: 'lynra_export',
    bytes: Uint8List.fromList(utf8.encode(buffer.toString())),
    ext: 'txt',
    mimeType: MimeType.text,
  );
	if (path == null) return;
	if (!mounted) return;
	final msg = skippedPattern > 0
  ? AppLocalizations.of(context)!
      .txtExportCompletedWithSkip
      .replaceFirst('%d', skippedPattern.toString())
  : AppLocalizations.of(context)!.txtExportCompleted;
	ScaffoldMessenger.of(context).showSnackBar(
		SnackBar(
			content: Text(
				msg,
				style: const TextStyle(
					color: AppColors.securityWarning,
					fontWeight: FontWeight.w500,
				),
			),
			duration: const Duration(seconds: 6),
		),
	);
Navigator.pop(context, true);
} finally {
    LynraApp.of(context).setSuspendAutoLock(false);
  }
}
Future<void> exportCSV() async {
LynraApp.of(context).setSuspendAutoLock(true);	
int skippedPattern = 0;
try {
final items = await repo.getItems(
    payloadKey: widget.payloadKey,
    collectionId: widget.collectionId,
  );
  String safe(String v) => '"${v.replaceAll('"', '""')}"';
  final buffer = StringBuffer();
  // header
  buffer.writeln('Title,Username,Password,IBAN,Note');
  for (final item in items) {
		if (item.type == "pattern") {
			skippedPattern++;
			continue;
		}
    buffer.writeln(
      '${safe(item.title)},${safe(item.username)},${safe(item.password)},${safe(item.iban)},${safe(item.note)}',
    );
  }
  final path = await FileSaver.instance.saveAs(
    name: 'lynra_export',
    bytes: Uint8List.fromList(utf8.encode(buffer.toString())),
    ext: 'csv',
    mimeType: MimeType.csv,
  );	
	if (path == null) return;
	if (!mounted) return;
	final msg = skippedPattern > 0
  ? AppLocalizations.of(context)!
      .txtExportCompletedWithSkip
      .replaceFirst('%d', skippedPattern.toString())
  : AppLocalizations.of(context)!.txtExportCompleted;
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
  content: Text(
    msg,
    style: const TextStyle(
      color: AppColors.securityWarning,
      fontWeight: FontWeight.w500,
    ),
  ),
  duration: const Duration(seconds: 6),
),
);
Navigator.pop(context, true);
} finally {
    LynraApp.of(context).setSuspendAutoLock(false);
  }
}	
	
Future<void> importTxt({
  required SecretKey payloadKey,
  required String collectionId,
}) async {
LynraApp.of(context).setSuspendAutoLock(true);
		int importedCount = 0;
		int duplicateCount = 0;
		int emptyTitleCount = 0;
		bool readingNote = false;
try {
  final result = await FilePicker.pickFiles(
  type: FileType.custom,
  allowedExtensions: ['txt'],
);
  if (result == null) return;
  final file = result.files.single;
  String content;
if (file.bytes != null) {
  content = String.fromCharCodes(file.bytes!);
} else {
  content = await File(file.path!).readAsString();
}
if (widget.payloadKey == null) return;
final mk = await _getUnwrappedMasterKey();
if (mk == null) return;
final existingItems = await repo.getItems(
  payloadKey: widget.payloadKey,
  collectionId: widget.collectionId,
);
final existingTitles = existingItems
    .map((e) => e.title.trim().toLowerCase())
    .toSet();		
final blocks = content
    .split('---')
    .map((e) => e.trim())
    .where((e) => e.isNotEmpty)
    .toList();		
		

for (final block in blocks) {
  final lines = block.split('\n');
  String title = '';
  String username = '';
  String password = '';
  String note = '';
  String iban = '';
  for (final line in lines) {
    final l = line.trim();
    if (readingNote &&
      !l.toLowerCase().startsWith('title:') &&
      !l.toLowerCase().startsWith('username:') &&
      !l.toLowerCase().startsWith('password:') &&
      !l.toLowerCase().startsWith('iban:') &&
      !l.toLowerCase().startsWith('note:')) {

    if (note.isNotEmpty) {
      note += '\n';
    }

    note += l;
    continue;
  }

  readingNote = false;

  if (l.toLowerCase().startsWith('title:')) {
    title = l.substring(6).trim();

  } else if (l.toLowerCase().startsWith('username:')) {
    username = l.substring(9).trim();

  } else if (l.toLowerCase().startsWith('password:')) {
    password = l.substring(9).trim();

  } else if (l.toLowerCase().startsWith('note:')) {
    note = l.substring(5).trim();
    readingNote = true;

  } else if (l.toLowerCase().startsWith('iban:')) {
    iban = l.substring(5).trim();
  }
}
	if (title.isEmpty) {
		emptyTitleCount++;
		continue;
	}
	final t = title.trim().toLowerCase();
	if (existingTitles.contains(t)) {
		duplicateCount++;
		continue;
	}
await repo.insertItem(
  payloadKey: widget.payloadKey,
  title: title,
  username: username,
  password: password,
  note: note,
  iban: iban,
  pattern: "",
  collectionId: widget.collectionId,
  type: "standard",
  id: const Uuid().v4(),
);	
	existingTitles.add(t);
  importedCount++;
}			
}
finally {
      LynraApp.of(context).setSuspendAutoLock(false);
  }
	
	if (!mounted) return;

final msg =
    "${AppLocalizations.of(context)!.imported}: $importedCount"
    " • ${AppLocalizations.of(context)!.duplicate}: $duplicateCount"
    " • ${AppLocalizations.of(context)!.empty}: $emptyTitleCount";

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      msg,
      style: const TextStyle(
        color: AppColors.favorite,
        fontWeight: FontWeight.w500,
      ),
    ),
    duration: const Duration(seconds: 6),
  ),
);

Navigator.pop(context, true);
}
Future<void> importCsv({
  required SecretKey payloadKey,
  required String collectionId,
}) async {
  LynraApp.of(context).setSuspendAutoLock(true);

  try {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result == null) return;

    final file = result.files.single;

    String content;

    if (file.bytes != null) {
      content = String.fromCharCodes(file.bytes!);
    } else {
      content = await File(file.path!).readAsString();
    }

    final lines = content
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty && !e.startsWith('#'))
        .toList();

    if (lines.isEmpty) return;

    // header check
    if (lines.first.toLowerCase() !=
        'title,username,password,iban,note') {
      throw Exception("Invalid CSV header");
    }

    final existingItems = await repo.getItems(
      payloadKey: payloadKey,
      collectionId: collectionId,
    );

    final existingTitles = existingItems
        .map((e) => e.title.trim().toLowerCase())
        .toSet();

    int importedCount = 0;
    int duplicateCount = 0;
    int emptyTitleCount = 0;

    // helper
    List<String> parseCsvLine(String line) {
      final result = <String>[];
      final buffer = StringBuffer();
      bool inQuotes = false;

      for (int i = 0; i < line.length; i++) {
        final char = line[i];

        if (char == '"') {
          if (inQuotes && i + 1 < line.length && line[i + 1] == '"') {
            buffer.write('"');
            i++;
          } else {
            inQuotes = !inQuotes;
          }
        } else if (char == ',' && !inQuotes) {
          result.add(buffer.toString());
          buffer.clear();
        } else {
          buffer.write(char);
        }
      }

      result.add(buffer.toString());
      return result;
    }

    // rows
    for (int i = 1; i < lines.length; i++) {
      final cols = parseCsvLine(lines[i]);

      if (cols.length < 5) continue;

      final title = cols[0].trim();
      final username = cols[1].trim();
      final password = cols[2].trim();
      final iban = cols[3].trim();
      final note = cols[4].trim();

      if (title.isEmpty) {
        emptyTitleCount++;
        continue;
      }

      final t = title.toLowerCase();

      if (existingTitles.contains(t)) {
        duplicateCount++;
        continue;
      }

      await repo.insertItem(
        payloadKey: payloadKey,
        title: title,
        username: username,
        password: password,
        note: note,
        iban: iban,
        pattern: "",
        collectionId: collectionId,
        type: "standard",
        id: const Uuid().v4(),
      );

      existingTitles.add(t);
      importedCount++;
    }

    if (!mounted) return;

final msg =
    "${AppLocalizations.of(context)!.imported}: $importedCount"
    " • ${AppLocalizations.of(context)!.duplicate}: $duplicateCount"
    " • ${AppLocalizations.of(context)!.empty}: $emptyTitleCount";

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      msg,
      style: const TextStyle(
        color: AppColors.favorite,
        fontWeight: FontWeight.w500,
      ),
    ),
    duration: const Duration(seconds: 6),
  ),
);


    Navigator.pop(context, true);
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
				content: Text(AppLocalizations.of(context)!.csvimportfailed),
      ),
    );
  } finally {
    LynraApp.of(context).setSuspendAutoLock(false);
  }
}


Future<void> downloadTxtTemplate() async {
  const content = '''
#
# LynraGreyNote txt Template
# Offline. Private. Yours.
#
# Fill the fields below and import this file into the app.
# Do not remove the separators (---)
#

Title:
Username:
Password:
IBAN:
Note:

---

Title:
Username:
Password:
IBAN:
Note:

---

Title:
Username:
Password:
IBAN:
Note:
''';

  final bytes = Uint8List.fromList(utf8.encode(content));

  //print("TXT TEMPLATE bytes length: ${bytes.length}");

  LynraApp.of(context).setSuspendAutoLock(true);

  try {
    await FileSaver.instance.saveAs(
      name: "LynraGreyNote_txt_template",
      bytes: bytes,
      ext: "txt",
      mimeType: MimeType.text,
    );
  } finally {
    LynraApp.of(context).setSuspendAutoLock(false);
  }
}

Future<void> downloadCsvTemplate() async {
  const content = '''
#
# LynraGreyNote CSV Template
# Offline. Private. Yours.
#
# Open this file in Excel or Google Sheets
# Do not change the header row
#

Title,Username,Password,IBAN,Note
Gmail,user@gmail.com,myPassword123,,Personal mail account
Netflix,user@gmail.com,netflixPass,,
''';

  LynraApp.of(context).setSuspendAutoLock(true);

  try {
    await FileSaver.instance.saveAs(
      name: "LynraGreyNote_csv_template",
      bytes: Uint8List.fromList(utf8.encode(content)),
      ext: "csv",
      mimeType: MimeType.csv,
    );
  } finally {
    LynraApp.of(context).setSuspendAutoLock(false);
  }
}
Future<void> openFeedback() async {
	String _appVersion = '';
	final infoapp = await PackageInfo.fromPlatform();
	_appVersion = "${infoapp.version}+${infoapp.buildNumber}";
	
  final info = await DeviceInfoPlugin().androidInfo;


  final body = '''
Message:

---

App version: $_appVersion
Android: ${info.version.release}
Device: ${info.manufacturer} ${info.model}
''';

  final uri = Uri(
    scheme: 'mailto',
    path: 'lynra.dev@gmail.com',
    queryParameters: {
      'subject': 'Lynra Feedback',
      'body': body,
    },
  );

  await launchUrl(uri);
}
  
}

class _Item extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _Item({
    required this.title,
    required this.onTap,
  });

  static const Color _primary = AppColors.accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(AppOpacity.subtle),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
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
class SecurityManifestoScreen extends StatelessWidget {
  const SecurityManifestoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.securityManifesto),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 LITE
            Text(
              l10n.securitySummaryTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              l10n.securitySummaryBody,
              style: const TextStyle(height: 1.5),
            ),

            const SizedBox(height: 24),

            // 🔹 ADVANCED
            Text(
              l10n.advancedSecurityTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              l10n.advancedSecurityBody,
              style: const TextStyle(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
