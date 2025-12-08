import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  //Database open / create
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //Table তৈরি
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      age INTEGER
    )
  ''');
  }

  //Insert ডাটা
  Future<int> insertUser(String name, int age) async {
    Database db = await DatabaseHelper().database;
    Map<String, dynamic> row = {'name': name, 'age': age};
    return await db.insert('users', row);
  }

  //Read ডাটা
  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await DatabaseHelper().database;
    return await db.query('users');
  }

  //update data
  Future<int> updateUser(int id, String name, int age) async {
    Database db = await DatabaseHelper().database;
    return await db.update(
      'users',
      {'name': name, 'age': age},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //delete data
  Future<int> deleteUser(int id) async {
    Database db = await DatabaseHelper().database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
