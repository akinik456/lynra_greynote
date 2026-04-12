import '../../../core/db/database_helper.dart';
import '../models/vault_collection.dart';

class CollectionRepository {
  final _dbHelper = DatabaseHelper.instance;

  Future<List<VaultCollection>> getCollections() async {
    final db = await _dbHelper.database;

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
    final db = await _dbHelper.database;
    final now = DateTime.now().millisecondsSinceEpoch;

    await db.insert('collections', {
      'id': id,
      'name': name,
      'createdAt': now,
      'updatedAt': now,
    });
  }
}