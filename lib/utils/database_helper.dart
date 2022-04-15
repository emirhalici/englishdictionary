import 'dart:async';
import 'package:english_dictionary/models/word_model.dart';
import 'package:sqflite/sqflite.dart';

const String tableName = 'tableWords';
const String tableFavoriteName = 'tableFavorites';
const String columnId = 'columnId';
const String columnWord = 'columnWord';
const String columnType = 'columnType';
const String columnDefinition = 'columnDefinition';
const String columnExample = 'columnExample';

class WordsDatabaseHelper {
  Future<String> getDatabasePath() async {
    var databasesPath = await getDatabasesPath();
    return databasesPath + tableName;
  }

  Future<Database> open(String path) async {
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            '''create table if not exists $tableName ($columnId integer primary key autoincrement, $columnWord text not null, $columnType text not null, $columnDefinition text not null, $columnExample text not null)''');
      },
    );
    return database;
  }

  Future<WordModel> insert(Database db, WordModel wordModel) async {
    wordModel.id = await db.insert(tableName, wordModel.toMap());
    return wordModel;
  }

  Future<List<String>> getWordTypes(Database db) async {
    List<Map> maps = await db.rawQuery('''SELECT DISTINCT $columnType FROM $tableName''');
    List<String> list = [];
    if (maps.isNotEmpty) {
      for (var item in maps) {
        list.add(item['columnType']);
      }
    }
    return list;
  }

  Future<WordModel?> getWord(Database db, int id) async {
    List<Map> maps = await db.query(tableName, where: '$columnId = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return wordModelFromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<WordModel>> getAllWords(Database db) async {
    List<Map> maps = await db.query(tableName);
    List<WordModel> words = [];
    if (maps.isNotEmpty) {
      for (var map in maps) {
        WordModel model = wordModelFromMap(map);
        words.add(model);
      }
    }
    return words;
  }

  Future<int> delete(Database db, int id) async {
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Database db, WordModel wordModel) async {
    return await db.update(tableName, wordModel.toMap(), where: '$columnId = ?', whereArgs: [wordModel.id]);
  }

  Future close(Database db) async => db.close();

  Future<String> getFavoriteDatabasePath() async {
    var databasesPath = await getDatabasesPath();
    return databasesPath + tableFavoriteName;
  }

  Future<Database> openFavorite(String path) async {
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            '''create table if not exists $tableFavoriteName ($columnId integer primary key autoincrement, $columnWord text not null, $columnType text not null, $columnDefinition text not null, $columnExample text not null)''');
      },
    );
    return database;
  }

  Future<WordModel> insertFavorite(Database db, WordModel wordModel) async {
    wordModel.id = await db.insert(tableFavoriteName, wordModel.toMap());
    print('added to favorites' + wordModel.toString());
    return wordModel;
  }

  Future<int> deleteFavorite(Database db, int id) async {
    return await db.delete(tableFavoriteName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<WordModel>> getAllFavoriteWords(Database db) async {
    List<Map> maps = await db.query(tableFavoriteName);
    List<WordModel> words = [];
    if (maps.isNotEmpty) {
      for (var map in maps) {
        WordModel model = wordModelFromMap(map);
        words.add(model);
      }
    }
    return words;
  }
}
