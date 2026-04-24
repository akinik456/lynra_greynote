import 'package:uuid/uuid.dart';
import 'package:cryptography/cryptography.dart';

import '../../../core/db/database_helper.dart';
import '../../../core/security/crypto_helper.dart';
import '../models/vault_item.dart';

class VaultRepository {
  final _dbHelper = DatabaseHelper.instance;
  final _uuid = const Uuid();

  Future<void> insertItem({
    required SecretKey payloadKey,
    required String title,
    required String username,
    required String password,
    required String note,
    required String iban,
    required String collectionId,
    required String type,
		required String id,
  }) async {
    final db = _dbHelper.getDb();
    final now = DateTime.now().millisecondsSinceEpoch;

    final item = VaultItem(
      id: id,
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
      hasAttachment: false,
    );

    final encryptedPayload =
        await CryptoHelper.encryptWithKey(item.toEncodedJson(), payloadKey);

    await db.insert('vault', {
      'id': item.id,
      'payload': encryptedPayload,
      'createdAt': now,
      'updatedAt': now,
      'isFavorite': 0,
      'collectionId': collectionId.isEmpty ? 'default' : collectionId,
      'hasAttachment': 0,
    });
  }

  Future<List<VaultItem>> getItems({
    required SecretKey payloadKey,
    required String collectionId,
  }) async {
    final db = _dbHelper.getDb();

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
        final decrypted =
            await CryptoHelper.decryptWithKey(encryptedPayload, payloadKey);

        final item = VaultItem.fromEncodedJson(decrypted);

        items.add(
          item.copyWith(
            hasAttachment: (row['hasAttachment'] ?? 0) == 1,
          ),
        );
				print("ITEM: ${item.title} ATTACH: ${(row['hasAttachment'] ?? 0)}");
      } catch (e) {
        // corrupted / wrong key / legacy payload skip
      }
    }

    return items;
  }

  Future<void> updateItem({
    required SecretKey payloadKey,
    required VaultItem oldItem,
    required String title,
    required String username,
    required String password,
    required String note,
    required String iban,
    required String type,
  }) async {
    final db = _dbHelper.getDb();
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
      hasAttachment: oldItem.hasAttachment,
    );

    final encryptedPayload =
        await CryptoHelper.encryptWithKey(updatedItem.toEncodedJson(), payloadKey);

    await db.update(
      'vault',
      {
        'payload': encryptedPayload,
        'updatedAt': now,
        'isFavorite': updatedItem.isFavorite ? 1 : 0,
        'collectionId': oldItem.collectionId,
        'hasAttachment': updatedItem.hasAttachment ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [oldItem.id],
    );
  }

  Future<void> deleteItem(String id) async {
    final db = _dbHelper.getDb();

    await db.delete(
      'vault',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
	
	Future<void> setHasAttachment({
		required String itemId,
		required bool hasAttachment,
	}) async {
		final db = _dbHelper.getDb();

		await db.update(
			'vault',
			{
				'hasAttachment': hasAttachment ? 1 : 0,
			},
			where: 'id = ?',
			whereArgs: [itemId],
		);
	}	
}