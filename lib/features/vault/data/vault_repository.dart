import 'package:uuid/uuid.dart';
import '../../../core/db/database_helper.dart';
import '../../../core/security/crypto_helper.dart';
import '../models/vault_item.dart';
import '../../../core/db/database_helper.dart';
import '../../auth/data/auth_storage.dart';

class VaultRepository {
  final _dbHelper = DatabaseHelper.instance;
  final _uuid = const Uuid();

  // 1. INSERT: vaultKey -> masterKey
  Future<void> insertItem({
    required String masterKey, 
    required String title,
    required String username,
    required String password,
    required String note,
    required String iban,
    required String collectionId,
    required String type,
  }) async {
    final db =  _dbHelper.getDb();
    final now = DateTime.now().millisecondsSinceEpoch;

    final item = VaultItem(
      id: _uuid.v4(),
      title: title,
      username: username,
      password: password,
      note: note,
      iban: iban,
      collectionId: collectionId,
      createdAt: now,
      updatedAt: now,
      lastChangedAt: now,
      isFavorite: false,
      type: type,
    );

    final encryptedPayload =
        await CryptoHelper.encrypt(item.toEncodedJson(), masterKey);

    await db.insert('vault', {
      'id': item.id,
      'payload': encryptedPayload,
      'createdAt': now,
      'updatedAt': now,
      'isFavorite': 0,
      'collectionId': collectionId.isEmpty ? 'default' : collectionId,
    });
  }

  // 2. GET: vaultKey -> masterKey
  Future<List<VaultItem>> getItems({
    required String masterKey,
    required String collectionId,
  }) async {
    final db =  _dbHelper.getDb();

    final rows = await db.query(
      'vault',
      where: 'collectionId = ?',
      whereArgs: [collectionId],
      orderBy: 'updatedAt DESC',
    );

    final items = <VaultItem>[];

    for (final row in rows) {
      try {
        final encryptedPayload = row['payload'] as String;
        // Master Key ile çözüyoruz
        final decrypted =
            await CryptoHelper.decrypt(encryptedPayload, masterKey);
        items.add(VaultItem.fromEncodedJson(decrypted));
      } catch (e) {
        // Çözülemezse (yanlış anahtar/bozuk veri) listeye eklemiyoruz
        print("Decryption error in getItems: $e");
      }
    }

    return items;
  }

  // 3. UPDATE: vaultKey -> masterKey
  Future<void> updateItem({
    required String masterKey,
    required VaultItem oldItem,
    required String title,
    required String username,
    required String password,
    required String note,
    required String iban,
    required String type,
  }) async {
    final db =  _dbHelper.getDb();
    final now = DateTime.now().millisecondsSinceEpoch;

    final passwordChanged = oldItem.password != password;

    final updatedItem = VaultItem(
      id: oldItem.id,
      title: title,
      username: username,
      password: password,
      note: note,
      iban: iban,
      collectionId: oldItem.collectionId,
      createdAt: oldItem.createdAt,
      updatedAt: now,
      lastChangedAt: passwordChanged ? now : oldItem.lastChangedAt,
      isFavorite: oldItem.isFavorite,
      type: type,
    );

    final encryptedPayload =
        await CryptoHelper.encrypt(updatedItem.toEncodedJson(), masterKey);

    await db.update(
      'vault',
      {
        'payload': encryptedPayload,
        'updatedAt': now,
        'isFavorite': updatedItem.isFavorite ? 1 : 0,
        'collectionId': oldItem.collectionId,
      },
      where: 'id = ?',
      whereArgs: [oldItem.id],
    );
  }

Future<void> deleteItem(String id) async {
    final db =  _dbHelper.getDb();
    await db.delete(
      'vault',
      where: 'id = ?',
      whereArgs: [id],
    );
  }}