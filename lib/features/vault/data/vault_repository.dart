import 'package:uuid/uuid.dart';
import '../../../core/db/database_helper.dart';
import '../../../core/security/crypto_helper.dart';
import '../models/vault_item.dart';

class VaultRepository {
  final _dbHelper = DatabaseHelper.instance;
  final _uuid = const Uuid();

  Future<void> insertItem({
    required String vaultKey,
    required String title,
    required String username,
    required String password,
    required String note,
  }) async {
    final db = await _dbHelper.database;
    final now = DateTime.now().millisecondsSinceEpoch;

    final item = VaultItem(
      id: _uuid.v4(),
      title: title,
      username: username,
      password: password,
      note: note,
      createdAt: now,
      updatedAt: now,
      lastChangedAt: now,
      isFavorite: false,
    );

    final encryptedPayload =
        await CryptoHelper.encrypt(item.toEncodedJson(), vaultKey);

    await db.insert('vault', {
      'id': item.id,
      'payload': encryptedPayload,
      'createdAt': now,
      'updatedAt': now,
      'isFavorite': 0,
    });
  }

  Future<List<VaultItem>> getItems(String vaultKey) async {
    final db = await _dbHelper.database;
    final rows = await db.query('vault', orderBy: 'updatedAt DESC');

    final items = <VaultItem>[];

    for (final row in rows) {
      try {
        final encryptedPayload = row['payload'] as String;
        final decrypted =
            await CryptoHelper.decrypt(encryptedPayload, vaultKey);
        items.add(VaultItem.fromEncodedJson(decrypted));
      } catch (_) {
      }
    }

    return items;
  }
  
Future<void> deleteItem(String id) async {
  final db = await _dbHelper.database;
  await db.delete(
    'vault',
    where: 'id = ?',
    whereArgs: [id],
  );
}  
  
}