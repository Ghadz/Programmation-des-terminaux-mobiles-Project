import 'package:path/path.dart';
import 'package:spacex/features/saved_items/data/models/saved_item.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static Database? _db;

  static const String databaseName = "saved_items.db";
  static const String tableName = "saved";

  // FIX #1: Return Future<Database> instead of dynamic
  Future<Database> get db async {
    if (_db != null) return _db!;

    String path = join(await getDatabasesPath(), databaseName);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return _db!;
  }

  // FIX #2: Make methods Future
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL UNIQUE,
        type TEXT NOT NULL,
        image TEXT NOT NULL,
        location TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS $tableName');
    await _onCreate(db, newVersion);
  }

  // FIX #3: Add proper error handling and use ConflictAlgorithm
  Future<SavedItemModel> saveItem(SavedItemModel item) async {
    try {
      Database database = await db;
      int record = await database.insert(
        tableName,
        {
          'title': item.title,
          'type': item.type,
          'image': item.imageUrl,
          'location': item.country,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return SavedItemModel(
        id: record,
        title: item.title,
        imageUrl: item.imageUrl,
        country: item.country,
        type: item.type,
      );
    } catch (e) {
      throw Exception('Error saving item: $e');
    }
  }

  // FIX #4: Proper type casting and error handling
  Future<List<SavedItemModel>> getSavedItems() async {
    try {
      Database database = await db;
      List<Map<String, dynamic>> savedItems = await database.query(
        tableName,
        columns: ["id", "title", "image", "location", "type"],
      );

      return savedItems.map((item) {
        return SavedItemModel(
          id: item['id'] as int,
          title: item['title'] as String,
          imageUrl: item['image'] as String,
          country: item['location'] as String,
          type: item['type'] as String,
        );
      }).toList();
    } catch (e) {
      throw Exception('Error retrieving items: $e');
    }
  }

  // FIX #5: Better null safety and error handling
  Future<bool> isSaved(String itemTitle) async {
    try {
      Database database = await db;
      List<Map<String, dynamic>> result = await database.query(
        tableName,
        where: "title = ?",
        whereArgs: [itemTitle],
        limit: 1,
      );
      return result.isNotEmpty;
    } catch (e) {
      throw Exception('Error checking saved item: $e');
    }
  }

  // FIX #6: Return int instead of Future<int>
  Future<int> delete(String title) async {
    try {
      Database database = await db;
      return await database.delete(
        tableName,
        where: "title = ?",
        whereArgs: [title],
      );
    } catch (e) {
      throw Exception('Error deleting item: $e');
    }
  }

  // FIX #7: Add close method for cleanup
  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}