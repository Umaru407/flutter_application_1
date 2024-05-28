import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_application_1/model/cook_diary_model.dart';

class DishdiaryDbHelper {
  static final DishdiaryDbHelper _instance = DishdiaryDbHelper._internal();
  factory DishdiaryDbHelper() => _instance;
  DishdiaryDbHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cook_diary.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cook_diary (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        image64bit TEXT,
        mealType INTEGER,
        dateTime TEXT
      )
    ''');
  }

  Future<int> insertCookDiary(CookDiaryModel cookDiary) async {
    Database db = await database;
    return await db.insert('cook_diary', cookDiary.toMap());
  }

  Future<List<CookDiaryModel>> getCookDiaries() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cook_diary');
    return List.generate(maps.length, (i) {
      return CookDiaryModel.fromMap(maps[i]);
    });
  }

  Future<int> updateCookDiary(CookDiaryModel cookDiary) async {
    Database db = await database;
    return await db.update(
      'cook_diary',
      cookDiary.toMap(),
      where: 'id = ?',
      whereArgs: [cookDiary.id],
    );
  }

  Future<int> deleteCookDiary(int id) async {
    Database db = await database;
    return await db.delete(
      'cook_diary',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
