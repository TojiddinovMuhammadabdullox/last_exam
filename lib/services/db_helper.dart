import 'package:last_exam/models/expense.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expenses.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE expenses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            amount REAL,
            date TEXT,
            isIncome INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertExpense(ExpenseModel expense) async {
    final db = await database;
    await db.insert('expenses', expense.toMap());
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    final db = await database;
    final maps = await db.query('expenses');

    return List.generate(maps.length, (i) {
      return ExpenseModel.fromMap(maps[i]);
    });
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    final db = await database;
    await db.update('expenses', expense.toMap(),
        where: 'id = ?', whereArgs: [expense.id]);
  }

  Future<void> deleteExpense(int id) async {
    final db = await database;
    await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
