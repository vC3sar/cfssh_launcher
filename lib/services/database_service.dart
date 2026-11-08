import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../features/shortcuts/shortcut_model.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cfssh_launcher.db');

    return await openDatabase(
      path,
      version: 3, // upgraded version
      onCreate: (db, version) async {
        await _createShortcutsTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await db.execute('DROP TABLE IF EXISTS servers');
          await _createShortcutsTable(db);
        }
      },
    );
  }

  Future<void> _createShortcutsTable(Database db) async {
    await db.execute('''
      CREATE TABLE shortcuts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        type TEXT NOT NULL,
        value TEXT NOT NULL,
        iconData TEXT
      )
    ''');
  }

  Future<int> insertShortcut(ShortcutModel shortcut) async {
    final db = await database;
    return await db.insert('shortcuts', shortcut.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteShortcut(int id) async {
    final db = await database;
    await db.delete('shortcuts', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ShortcutModel>> getShortcuts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('shortcuts');
    return List.generate(maps.length, (i) {
      return ShortcutModel.fromMap(maps[i]);
    });
  }
}
