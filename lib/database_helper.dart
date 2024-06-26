//database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as p;


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'calculator.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE calculation_history(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        expression TEXT,
        result TEXT,
        timestamp TEXT
      )
    ''');
  }
}
