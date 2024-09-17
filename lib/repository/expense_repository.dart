import 'package:last_exam/models/expense.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseRepository {
  static final ExpenseRepository _instance = ExpenseRepository._internal();
  factory ExpenseRepository() => _instance;

  static Database? _database;

  ExpenseRepository._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/expenses.db';

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE expenses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            amount REAL,
            date TEXT
          )
        ''');
      },
    );
  }

  Future<int> addExpense(ExpenseModel expense) async {
    final db = await database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<List<ExpenseModel>> fetchExpenses() async {
    final db = await database;
    final result = await db.query('expenses');
    return result.map((e) => ExpenseModel.fromMap(e)).toList();
  }

  Future<int> deleteExpense(int id) async {
    final db = await database;
    return await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateExpense(ExpenseModel expense) async {
    final db = await database;
    return await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }
}
