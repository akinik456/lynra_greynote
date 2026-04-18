import '../../../core/db/database_helper.dart';
import '../models/vault_collection.dart';
import '../../../core/db/database_helper.dart';
import '../../auth/data/auth_storage.dart';


class CollectionRepository {
  final _dbHelper = DatabaseHelper.instance;

  Future<List<VaultCollection>> getCollections() async {
    final db =  _dbHelper.getDb();

    final rows = await db.query(
      'collections',
      orderBy: 'createdAt ASC',
    );

    return rows.map((e) => VaultCollection.fromMap(e)).toList();
  }

  Future<void> insertCollection({
    required String id,
    required String name,
  }) async {
    final db =  _dbHelper.getDb();
    final now = DateTime.now().millisecondsSinceEpoch;

    await db.insert('collections', {
      'id': id,
      'name': name,
      'createdAt': now,
      'updatedAt': now,
    });
  }
Future<void> deleteCollection(String collectionId) async {
  final db =  _dbHelper.getDb();

  if (collectionId == 'default') return;

  await db.delete(
    'vault',
    where: 'collectionId = ?',
    whereArgs: [collectionId],
  );

  await db.delete(
    'collections',
    where: 'id = ?',
    whereArgs: [collectionId],
  );
}  
  
}