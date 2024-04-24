import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'calculator_history.dart';

class HistoryDatabase {
  static final HistoryDatabase instance = HistoryDatabase._privateConstructor();
  static Database? _database;

  HistoryDatabase._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'history.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        expression TEXT,
        result TEXT,
        timestamp TEXT
      )
    ''');
  }

  Future<int> insertHistory(CalculationHistory history) async {
    Database db = await instance.database;
    return await db.insert('history', history.toMap());
  }

  Future<List<CalculationHistory>> getHistory() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('history');
    return List.generate(maps.length, (i) {
      return CalculationHistory(
        id: maps[i]['id'],
        expression: maps[i]['expression'],
        result: maps[i]['result'],
        timestamp: DateTime.parse(maps[i]['timestamp']),
      );
    });
  }
}
