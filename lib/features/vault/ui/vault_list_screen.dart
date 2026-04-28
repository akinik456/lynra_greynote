import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../l10n/app_localizations.dart';
import '../../../core/db/database_helper.dart';
import '../data/vault_repository.dart';
import '../models/vault_item.dart';
import 'add_edit_screen.dart';
import 'vault_detail_screen.dart';
import '../data/collection_repository.dart';
import '../models/vault_collection.dart';
import '../../settings/ui/settings_screen.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/data/auth_storage.dart';
import '../../../core/security/crypto_helper.dart';
import '../../../core/security/inactivity_lock_wrapper.dart';
import '../../../core/attachments/attachment_service.dart';
import '../../auth/data/auth_storage.dart';
import '../../../main.dart';



class VaultListScreen extends StatefulWidget {
  final String vaultKey ;
  const VaultListScreen({
    super.key,
    required this.vaultKey, // Zorunlu hale getir
  });
@override
  State<VaultListScreen> createState() => _VaultListScreenState();
}
class _VaultListScreenState extends State<VaultListScreen> {
  final repo = VaultRepository();
  
  String selectedCollectionId = 'default';
  final collectionRepo = CollectionRepository();
  bool isVaultUnlocked = false;
  bool isVaultWordEnabled = false;
  final storage = const FlutterSecureStorage();
	StreamSubscription<List<PurchaseDetails>>? _purchaseSub;
	bool _isPremium = false;
	
  List<VaultCollection> collections = [];
  List<VaultItem> items = [];

  static const Color _bgColor = Color(0xFF020617);
  static const Color _cardColor = Color(0xFF0F172A);
  static const Color _chipColor = Color(0xFF1E293B);
  static const Color _primary = Color(0xFF22D3EE);
  static const Color _textPrimary = Color(0xFFE2E8F0);
  static const Color _textSecondary = Color(0xFF94A3B8);
  static const Color _borderColor = Color(0xFF334155);
  String? _masterKey;
  SecretKey? _payloadKey;
  int itemCount = 0;
  int collectionCount = 0;
  String searchQuery = "";
  
  @override
void initState() {
  super.initState();

  _loadPremium();
  loadVaultWordSettings();
  _initFlow();

  _purchaseSub = InAppPurchase.instance.purchaseStream.listen((purchases) async {
    final prefs = await SharedPreferences.getInstance();

    for (final purchase in purchases) {
      if ((purchase.status == PurchaseStatus.purchased ||
              purchase.status == PurchaseStatus.restored) &&
          purchase.productID == 'lynragreynote') {
        debugPrint('IAP PREMIUM UNLOCKED');

        setState(() {
          _isPremium = true;
        });

        await prefs.setBool('isPremium', true);

        if (purchase.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchase);
        }
      }

      if (purchase.status == PurchaseStatus.error) {
        debugPrint('IAP error: ${purchase.error}');
      }
    }
  });

  InAppPurchase.instance.restorePurchases();
}
	
	@override
void dispose() {
  _purchaseSub?.cancel();
  super.dispose();
}

Future<void> _loadPremium() async {
  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getBool('isPremium') ?? false;

  if (saved) {
    setState(() {
      _isPremium = true;
    });
  }
}
  
Future<void> _initFlow() async {
//print(DateTime.now());
//print("Time_Check4");
  final mk = await _getUnwrappedMasterKey();
  if (mk == null) return;
//print(DateTime.now());
//print("Time_Check5");
  _masterKey = mk;
  _payloadKey = await CryptoHelper.derivePayloadKey(mk);
//print(DateTime.now());
//print("Time_Check6");  
  final derivedDbKey = await CryptoHelper.deriveDbKey(mk);
//print(DateTime.now());
//print("Time_Check7");
  await DatabaseHelper.instance.openWithKey(derivedDbKey);
//print(DateTime.now());
//print("Time_Check8");
  await loadCollections();
//print(DateTime.now());
//print("Time_Check9");  
  await load();
//print(DateTime.now());
//print("Time_Check10");
}

Future<String?> _getUnwrappedMasterKey() async {
  // 1. Paketli anahtarı oku
  final wrappedMK = await AuthStorage.getWrappedMasterKey();
  
  // 2. Eğer henüz paketli anahtar yoksa (Onboarding hatası veya ilk kurulum)
  if (wrappedMK == null) {
    return null;
  }

  try {
    // 3. Çözme işlemini başlat
    return await CryptoHelper.unwrapMasterKey(
      wrappedMKBase64: wrappedMK,
      password: widget.vaultKey, // Pattern/PIN
    );
  } catch (e) {
    // Eğer buraya düşüyorsa: Ya şifre yanlış ya da paketleme hatalı (MAC Hatası)
    return null;
  }
}

 Future<void> load() async {
  if (_payloadKey == null) return;

  final result = await repo.getItems(
    payloadKey: _payloadKey!,
    collectionId: selectedCollectionId,
  );

  result.sort((a, b) {
    final at = a.title.trim().toLowerCase();
    final bt = b.title.trim().toLowerCase();

    if (at.isEmpty) return 1;
    if (bt.isEmpty) return -1;

    return at.compareTo(bt);
  });

  setState(() => items = result);
  itemCount = result.length;
}

  Future<void> loadCollections() async {
    final result = await collectionRepo.getCollections();
	collectionCount = result.length;
    setState(() {
      collections = result;
      if (collections.isNotEmpty &&
          !collections.any((c) => c.id == selectedCollectionId)) {
        selectedCollectionId = collections.first.id;
      }
    });
  }
  
List<VaultItem> get filteredItems {
  if (searchQuery.trim().isEmpty) return items;

  final q = searchQuery.toLowerCase();

  return items.where((item) {
    return item.title.toLowerCase().contains(q) ||
        item.username.toLowerCase().contains(q) ||
        item.note.toLowerCase().contains(q);
  }).toList();
  
}  

  Future<void> loadVaultWordSettings() async {
    final enabled = await storage.read(key: "vault_word_enabled");
    setState(() {
      isVaultWordEnabled = enabled == "true";
      isVaultUnlocked = false;
    });
  }

  Future<void> openAdd() async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const AddEditScreen()),
  );

  if (result == null) return;

  final attachmentBytes = result['attachmentBytes'] as Uint8List?;
  final attachmentType = result['attachmentType'] as String?;

  print("ATTACHMENT: $attachmentType / ${attachmentBytes?.length}");

    final mk = await _getUnwrappedMasterKey();
    if (mk == null) return;
final itemId = Uuid().v4();
    await repo.insertItem(
		id: itemId,
      payloadKey: _payloadKey!,
      title: result["title"] ?? "",
      username: result["username"] ?? "",
      password: result["password"] ?? "",
      note: result["note"] ?? "",
      iban: result["iban"] ?? "",
			pattern: result["pattern"] ?? "",
      collectionId: selectedCollectionId,
      type: result["type"] ?? "standard",
    );
		
		if (attachmentBytes != null && attachmentType != null) {
  final service = AttachmentService();

  await service.saveEncryptedAttachment(
    itemId: itemId,
    type: attachmentType,
    bytes: attachmentBytes,
    key: _payloadKey!,
  );

  await repo.setHasAttachment(
    itemId: itemId,
    hasAttachment: true,
  );

  print("ATTACH FLAG TRUE SET FOR: $itemId");
}
    await load();
}

Future<void> delete(VaultItem item) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: const Color(0xFF0F172A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TITLE
              Text(
                AppLocalizations.of(context)!.deleteEntry,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFE2E8F0),
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 12),

              // CONTENT
              Text(
                AppLocalizations.of(context)!
                    .deleteEntryConfirm(item.title),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 24),

              // BUTTONS
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          Navigator.pop(context, false),
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
													backgroundColor: const Color(0xFF22D3EE), // cyan
													foregroundColor: Colors.black,
													shape: RoundedRectangleBorder(
														borderRadius: BorderRadius.circular(14),
													),
													elevation: 0,
												),
                        onPressed: () =>
                            Navigator.pop(context, true),
                        child: Text(
                          AppLocalizations.of(context)!.delete,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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

  if (confirmed == true) {
    await repo.deleteItem(item.id);
    await load();
  }
}

  String formatDate(int ts) {
    final dt = DateTime.fromMillisecondsSinceEpoch(ts);
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final year = dt.year.toString();
    return '$day.$month.$year';
  }

  @override
  Widget build(BuildContext context) {
    final shouldHide = isVaultWordEnabled && !isVaultUnlocked;

    return InactivityLockWrapper(
  onTimeout: () {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) =>  AppGate()),
      (route) => false,
    );
  },
  child:  Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _bgColor,
        surfaceTintColor: _bgColor,
        centerTitle: true,
        elevation: 0,
        title: RichText(
					text: TextSpan(
						children: [
							const TextSpan(
								text: 'LynraGreyNote',
								style: TextStyle(
									color: Color(0xFF22D3EE), // cyan_textPrimary,
									fontWeight: FontWeight.w700,
									letterSpacing: 0.2,
									fontSize: 18,
								),
							),
							if (_isPremium)
								const TextSpan(
									text: ' ✦',
									style: TextStyle(
										color: Color(0xFF22D3EE), // cyan
										fontWeight: FontWeight.w700,
									),
								),
						],
					),
				),
        actions: [
          IconButton(
			  icon: const Icon(Icons.settings_outlined, color: _textPrimary),
			  onPressed: () async {
				final result = await Navigator.push(
				  context,
				  MaterialPageRoute(
					builder: (_) => SettingsScreen(
						vaultKey: widget.vaultKey,
						payloadKey: _payloadKey!,
					),
				  ),
				);
				if (result == true) {
				  await loadCollections();
				  await load();
				}
			  },
			),
          IconButton(
            icon: Icon(
              shouldHide ? Icons.lock_outline : Icons.lock_open_rounded,
              color: _textPrimary,
            ),
            onPressed: showVaultUnlockDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _VaultHeaderCard(
              totalItems: items.length,
              currentCollectionName: (() {
				  final selected = collections
					  .where((c) => c.id == selectedCollectionId)
					  .cast<VaultCollection?>()
					  .firstWhere((c) => c != null, orElse: () => null);

				  if (selected == null) return AppLocalizations.of(context)!.myVault;
				  if (selected.id == 'default') return AppLocalizations.of(context)!.myVault;
				  return selected.name;
				})(),
              isLocked: shouldHide,
            ),
          ),
          _CollectionBar(
            collections: collections,
            selectedCollectionId: selectedCollectionId,
            onSelected: (id) async {
              setState(() {
                selectedCollectionId = id;
              });
              await load();
            },
            onAdd: () {
			  if (!_isPremium && collections.length >= 2) {
				showUpgradeDialog();
				return;
			  }
			  openAddCollection();
			},
            onDelete: openDeleteCollection,
          ),
		  Padding(
			  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
			  child: TextField(
			  enabled: !shouldHide,
				onChanged: (value) {
				  setState(() {
					searchQuery = value;
				  });
				},
				decoration: InputDecoration(
				  hintText: shouldHide
					? AppLocalizations.of(context)!.unlockToSearch
					: AppLocalizations.of(context)!.search,
				  prefixIcon: const Icon(Icons.search),
				  filled: true,
				  fillColor: const Color(0xFF1E293B),
				  border: OutlineInputBorder(
					borderRadius: BorderRadius.circular(16),
					borderSide: BorderSide.none,
				  ),
				),
			  ),
			),
          Expanded(
            child: filteredItems.isEmpty
                ? const _EmptyState()
                : RefreshIndicator(
                    onRefresh: load,
                    color: _primary,
                    backgroundColor: _cardColor,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];

                        return _VaultCard(
                          item: item,
                          shouldHide: shouldHide,
                          formattedDate: formatDate(item.updatedAt),
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VaultDetailScreen(
                                  item: item,
                                  shouldHide: shouldHide,
																	payloadKey: _payloadKey!,
                                ),
                              ),
                            );
														if (result == true) {
															await load();
															return;
														}
                            if (result != null) {
															final mk = await _getUnwrappedMasterKey();
															if (mk == null) return;
															final attachmentBytes = result["attachmentBytes"] as Uint8List?;
															final attachmentType = result["attachmentType"] as String?;

															await repo.updateItem(
															payloadKey: _payloadKey!,
															oldItem: item,
															title: result["title"] ?? "",
															username: result["username"] ?? "",
															password: result["password"] ?? "",
															note: result["note"] ?? "",
															iban: result["iban"] ?? "",
															type: result["type"] ?? "standard",
															);
															if (attachmentBytes != null && attachmentType != null) {
																final service = AttachmentService();

																await service.saveEncryptedAttachment(
																	itemId: item.id,
																	type: attachmentType,
																	bytes: attachmentBytes,
																	key: _payloadKey!,
																);

																await repo.setHasAttachment(
																	itemId: item.id,
																	hasAttachment: true,
																);
															}
															await load();
														}
                          },
                          onLongPress: () => delete(item),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _primary,
        foregroundColor: Colors.black,
        onPressed: () {
					if (!_isPremium && collections.length >= 2) {
					showUpgradeDialog();
					return;
					}
					openAdd();
				},
        child: const Icon(Icons.add),
      ),
			
			
			
			
    ),
	);	
  }
  Future<void> showVaultUnlockDialog() async {
    final ctrl = TextEditingController();

    final result = await showDialog<bool>(
  context: context,
  builder: (context) {
    return Dialog(
      backgroundColor: const Color(0xFF0F172A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.unlockContent,
							textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFE2E8F0),
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              decoration: BoxDecoration(
                color: const Color(0xFF020617),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
              child: TextField(
                controller: ctrl,
                style: const TextStyle(color: Color(0xFFE2E8F0)),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enterVaultWord,
                  hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(AppLocalizations.of(context)!.cancel,
                      style: TextStyle(color: Color(0xFF94A3B8)),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22D3EE),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      final saved = await storage.read(key: "vault_word");

                      final ok = saved != null &&
                          saved.toLowerCase() ==
                              ctrl.text.toLowerCase();

                      Navigator.pop(context, ok);
                    },
                    child: Text(AppLocalizations.of(context)!.unlock),
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

    if (result == true) {
      setState(() {
        isVaultUnlocked = true;
      });
    }
  }

void showUpgradeDialog() {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: const Color(0xFF0F172A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TITLE
            Text(
              AppLocalizations.of(context)!.limitReached,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFE2E8F0),
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 16),

            // CONTENT
            Text(
              AppLocalizations.of(context)!.freeLimitEntries,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 24),

            // BUTTONS
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF22D3EE),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () async {
  Navigator.pop(context);

  const productId = 'lynragreynote';

  final response = await InAppPurchase.instance.queryProductDetails({
    productId,
  });

  if (response.productDetails.isEmpty) {
    debugPrint('Product not found');
    return;
  }

  final product = response.productDetails.first;

  final purchaseParam = PurchaseParam(productDetails: product);

  InAppPurchase.instance.buyNonConsumable(
    purchaseParam: purchaseParam,
  );
},
                      child: Text(
                        AppLocalizations.of(context)!.upgrade,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
  Future<void> openAddCollection() async {
    if (collections.length >= 50) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.max5Collections),
        ),
      );
      return;
    }

    final controller = TextEditingController();
    final result = await showDialog<String>(
  context: context,
  builder: (context) {
    return Dialog(
      backgroundColor: const Color(0xFF0F172A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.newCollection,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFE2E8F0),
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: controller,
              autofocus: true,
              style: const TextStyle(color: Color(0xFFE2E8F0)),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.collectionExample,
                hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                filled: true,
                fillColor: const Color(0xFF020617),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: const TextStyle(color: Color(0xFF94A3B8)),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22D3EE),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      final name = controller.text.trim();
                      if (name.isEmpty) return;
                      Navigator.pop(context, name);
                    },
                    child: Text(AppLocalizations.of(context)!.add),
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

    if (result == null || result.trim().isEmpty) return;

    final id = result.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '_');

    await collectionRepo.insertCollection(
      id: id,
      name: result.trim(),
    );

    await loadCollections();

    setState(() {
      selectedCollectionId = id;
    });

    await load();
  }

  Future<void> openDeleteCollection(VaultCollection collection) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: const Color(0xFF0F172A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TITLE
              Text(
                AppLocalizations.of(context)!.deleteCollection,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFE2E8F0),
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 12),

              // CONTENT
              Text(
                AppLocalizations.of(context)!
                    .deleteCollectionConfirm(collection.name),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 24),

              // BUTTONS
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF22D3EE),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(
                          AppLocalizations.of(context)!.delete,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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

  if (confirmed != true) return;

  await collectionRepo.deleteCollection(collection.id);

  await loadCollections();

  setState(() {
    selectedCollectionId = 'default';
  });

  await load();
}
	
}

class _VaultHeaderCard extends StatelessWidget {
  final int totalItems;
  final String currentCollectionName;
  final bool isLocked;

  const _VaultHeaderCard({
    required this.totalItems,
    required this.currentCollectionName,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.04),
            Colors.white.withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF334155).withOpacity(0.65),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFF22D3EE).withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF22D3EE).withOpacity(0.22),
              ),
            ),
            child: Icon(
              isLocked ? Icons.lock_outline : Icons.lock_open_rounded,
              color: const Color(0xFF22D3EE),
              size: 28,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.collection,
                  style: TextStyle(
                    color: Color(0xFFE2E8F0),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
				  AppLocalizations.of(context)!.vaultHeaderStats(
					currentCollectionName,
					totalItems,
				  ),
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VaultCard extends StatelessWidget {
  final VaultItem item;
  final String formattedDate;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool shouldHide;

  const _VaultCard({
    required this.item,
    required this.formattedDate,
    required this.onTap,
    required this.onLongPress,
    required this.shouldHide,
  });

  String randomFakeText() {
    final fake = [
      "system buffer",
      "encrypted block",
      "null segment",
      "hidden layer",
      "data masked",
    ];
    fake.shuffle();
    return fake.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22D3EE).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      (item.title.isNotEmpty ? item.title[0] : '?').toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF22D3EE),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
  children: [
    Expanded(
      child: Text(
        shouldHide
            ? randomFakeText()
            : (item.title.isEmpty
                ? AppLocalizations.of(context)!.untitled
                : item.title),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Color(0xFFE2E8F0),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    if (item.hasAttachment)
      const Padding(
        padding: EdgeInsets.only(left: 6),
        child: Icon(
          Icons.attach_file,
          size: 16,
          color: Colors.white70,
        ),
      ),
  ],
),
                      if (item.type == "standard") ...[
  const SizedBox(height: 4),
  Text(
    shouldHide
        ? randomFakeText()
        : (item.username.isEmpty
            ? AppLocalizations.of(context)!.noUsername
            : item.username),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: 13,
      color: Colors.white.withOpacity(0.68),
    ),
  ),
],
                      SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.updatedDate(formattedDate),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.42),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white.withOpacity(0.45),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 78,
              height: 78,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
              child: const Icon(
                Icons.lock_outline,
                size: 36,
                color: Color(0xFF22D3EE),
              ),
            ),
            const SizedBox(height: 18),
            Text(
						AppLocalizations.of(context)!.noEntriesYet,
              style: TextStyle(
                color: Color(0xFFE2E8F0),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
							AppLocalizations.of(context)!.addFirstSecureEntry,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.62),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CollectionBar extends StatelessWidget {
  final List<VaultCollection> collections;
  final String selectedCollectionId;
  final ValueChanged<String> onSelected;
  final VoidCallback onAdd;
  final Function(VaultCollection) onDelete;

  const _CollectionBar({
    required this.collections,
    required this.selectedCollectionId,
    required this.onSelected,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (collections.isEmpty) {
      return const SizedBox(height: 12);
    }

    return SizedBox(
      height: 62,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
        scrollDirection: Axis.horizontal,
        itemCount: collections.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == collections.length) {
            return ActionChip(
              avatar: const Icon(
                Icons.add,
                size: 16,
                color: Color(0xFF22D3EE),
              ),
              label: Text(AppLocalizations.of(context)!.collection),
              onPressed: onAdd,
              backgroundColor: const Color(0xFF1E293B),
              side: BorderSide(
                color: Colors.white.withOpacity(0.05),
              ),
              labelStyle: const TextStyle(
                color: Color(0xFF22D3EE),
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            );
          }

          final collection = collections[index];
          final selected = collection.id == selectedCollectionId;

          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onLongPress: collection.id == 'default' ? null : () => onDelete(collection),
            child: ChoiceChip(
              label: Text(
  collection.id == 'default'
      ? AppLocalizations.of(context)!.myVault
      : collection.name,
),
              selected: selected,
              onSelected: (_) => onSelected(collection.id),
              selectedColor: const Color(0xFF22D3EE),
              backgroundColor: const Color(0xFF1E293B),
              side: BorderSide(
                color: selected
                    ? const Color(0xFF22D3EE)
                    : Colors.white.withOpacity(0.05),
              ),
              labelStyle: TextStyle(
                color: selected ? Colors.black : Colors.white,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          );
        },
      ),
    );
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}