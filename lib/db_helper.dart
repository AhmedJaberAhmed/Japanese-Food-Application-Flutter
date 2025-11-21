import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/food.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;


    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'sushi_app.db');


    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {

    await db.execute('''
      CREATE TABLE cart (
        name TEXT PRIMARY KEY,
        price TEXT,
        imagePath TEXT,
        ratting TEXT,
        description TEXT,
        quantity INTEGER
      )
    ''');


    await db.execute('''
      CREATE TABLE favorites (
        name TEXT PRIMARY KEY,
        price TEXT,
        imagePath TEXT,
        ratting TEXT,
        description TEXT
      )
    ''');
  }



  Future<void> insertCartItem(Food food, int quantity) async {
    final db = await database;
    await db.insert(
      'cart',
      {
        'name': food.name,
        'price': food.price,
        'imagePath': food.imagePath,
        'ratting': food.ratting,
        'description': food.description,
        'quantity': quantity,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteCartItem(String name) async {
    final db = await database;
    await db.delete(
      'cart',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<List<Map<String, dynamic>>> getCartItemsRaw() async {
    final db = await database;
    return await db.query('cart');
  }



  Future<void> insertFavorite(Food food) async {
    final db = await database;
    await db.insert(
      'favorites',
      {
        'name': food.name,
        'price': food.price,
        'imagePath': food.imagePath,
        'ratting': food.ratting,
        'description': food.description,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(String name) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<List<Map<String, dynamic>>> getFavoriteItemsRaw() async {
    final db = await database;
    return await db.query('favorites');
  }
}
