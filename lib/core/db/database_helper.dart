import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  static const _dbName = 'lynra.db';
  static const _dbVersion = 2;

  DatabaseHelper._init();

  Future<Database> _initDB(String filePath, String password) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
	  password: password,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: _onOpen,
    );
  }
  
Future<Database> openWithKey(String password) async {
  if (_database != null) return _database!;
  _database = await _initDB(_dbName, password);
  return _database!;
}  
Future<void> close() async {
  if (_database != null) {
    await _database!.close();
    _database = null;
  }
}
Database getDb() {
  if (_database == null) {
    throw Exception('DB not opened yet!');
  }
  return _database!;
}
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE vault (
        id TEXT PRIMARY KEY,
        payload TEXT NOT NULL,
        createdAt INTEGER NOT NULL,
        updatedAt INTEGER NOT NULL,
        isFavorite INTEGER NOT NULL,
        collectionId TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE collections (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        createdAt INTEGER NOT NULL,
        updatedAt INTEGER NOT NULL
      )
    ''');

    await _ensureDefaultCollection(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS collections (
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          createdAt INTEGER NOT NULL,
          updatedAt INTEGER NOT NULL
        )
      ''');

      final tableInfo = await db.rawQuery("PRAGMA table_info(vault)");
      final hasCollectionId =
          tableInfo.any((row) => row['name'] == 'collectionId');

      if (!hasCollectionId) {
        await db.execute(
          "ALTER TABLE vault ADD COLUMN collectionId TEXT NOT NULL DEFAULT 'default'",
        );
      } else {
        await db.execute(
          "UPDATE vault SET collectionId = 'default' WHERE collectionId IS NULL OR collectionId = ''",
        );
      }

      await _ensureDefaultCollection(db);
    }
  }

  Future<void> _onOpen(Database db) async {
    await _ensureDefaultCollection(db);

    await db.execute(
      "UPDATE vault SET collectionId = 'default' WHERE collectionId IS NULL OR collectionId = ''",
    );
  }

  Future<void> _ensureDefaultCollection(Database db) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    await db.insert(
      'collections',
      {
        'id': 'default',
        'name': 'My Vault',
        'createdAt': now,
        'updatedAt': now,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}