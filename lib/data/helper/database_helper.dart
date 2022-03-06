import 'package:restaurant_app/data/model/list_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  static const String _tblFavorite = 'favorite';

  Future<Database> _initializeDb() async {
    final path = await getDatabasesPath();
    final db = openDatabase(
      '$path/favorite.db',
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $_tblFavorite(id TEXT PRIMARY KEY, name TEXT,  description TEXT, city TEXT, pictureId TEXT, rating DOUBLE)');
      },
      version: 1,
    );
    return db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
    return _database!;
  }

  Future<void> addFavorite(ListRestaurantItem restaurant) async {
    final db = await database;
    await db.insert(
      _tblFavorite,
      restaurant.toJson(),
    );
  }

  Future<List<ListRestaurantItem>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(_tblFavorite);

    return result.map((e) => ListRestaurantItem.fromJson(e)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;
    await db.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
