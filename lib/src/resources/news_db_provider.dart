import 'dart:io';
import 'package:Hacker_News/src/models/item_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NewsDbProvider {
  // SQL Query
  final String table = 'Items';
  final String _sql = """ 
    CREATE TABLE Items 
      (
        id INTEGER PRIMARY KEYS,
        type TEXT,
        by TEXT, 
        time INTEGER,
        text TEXT,
        parent INTEGER,
        kids BLOB,
        dead INTEGER,
        deleted INTEGER,
        url TEXT,
        score INTEGER,
        title TEXT,
        descendants INTEGER
      )
  """;

  Database db;

  init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "items.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute(_sql);
      },
    );
  }

  fetchItem(int id) async {
    final maps = await db.query(
      table,
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  addItem(ItemModel item) async {
    return db.insert(table, item.toMap());
  }
}
