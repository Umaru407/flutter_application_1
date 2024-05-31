import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_application_1/model/cook_diary_model.dart';

class DishDiaryDbHelper {
  static final DishDiaryDbHelper _instance = DishDiaryDbHelper._internal();
  factory DishDiaryDbHelper() => _instance;
  DishDiaryDbHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cook_diary4.db');
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
        mealType TEXT,
        dateTime TEXT
      )
    ''');
  }

  Future<int> insertCookDiary(CookDiaryModel cookDiary) async {
    Database db = await database;
    print("111");
    print(cookDiary.toMap());
    return await db.insert('cook_diary', cookDiary.toMap());
  }

  // Future<List<CookDiaryModel>> getCookDiaries() async {
  //   Database db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query('cook_diary');
  //   return List.generate(maps.length, (i) {
  //     return CookDiaryModel.fromMap(maps[i]);
  //   });
  // }

  Future<List<CookDiaryModel>> getCookDiaries2(String mealType) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db
        .rawQuery('SELECT * FROM cook_diary WHERE mealType = ?', ['$mealType']);

    final List<CookDiaryModel> list = List.generate(maps.length, (i) {
      return CookDiaryModel.fromMap(maps[i]);
    });

    return list;
  }

  Future<List<CookDiaryModel>> getCookDiaries(
      String mealType, DateTime date) async {
    Database db = await database;

    // 将 DateTime 转换为 ISO 8601 字符串格式，并截取日期部分 YYYY-MM-DD
    String queryDate = date.toIso8601String().substring(0, 10);

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM cook_diary WHERE mealType = ? AND dateTime LIKE ?',
        [mealType, '$queryDate%'] // 使用 LIKE 进行匹配日期部分
        );

    final List<CookDiaryModel> list = List.generate(maps.length, (i) {
      return CookDiaryModel.fromMap(maps[i]);
    });

    return list;
  }

// List.generate(maps.length, (i) {
//       print("@@@@@@@@@@@@@@@");
//       print(maps[i]);
//       print(CookDiaryModel.fromMap(maps[i]));

//       final a = CookDiaryModel.fromMap(maps[i]);
//       print("aaa");
//       print(a);
//       //  print(CookDiaryModel.toMap(maps[i]));
//       return CookDiaryModel.fromMap(maps[i]);
//     });

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
