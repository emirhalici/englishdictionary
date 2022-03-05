import 'dart:async';

import 'package:english_dictionary/utils/objects.dart';
import 'package:sqflite/sqflite.dart';

const String tableName = 'tableWords';
const String columnId = 'columnId';
const String columnWord = 'columnWord';
const String columnType = 'columnType';
const String columnDefinition = 'columnDefinition';
const String columnExample = 'columnExample';

class WordsDatabaseProvider {
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
            '''create table $tableName ($columnId integer primary key autoincrement, $columnWord text not null, $columnType text not null, $columnDefinition text not null, $columnExample text not null)''');
      },
    );
    return database;
  }

  Future<WordModel> insert(Database db, WordModel wordModel) async {
    wordModel.id = await db.insert(tableName, wordModel.toMap());
    return wordModel;
  }

  Future<WordModel?> getWord(Database db, int id) async {
    List<Map> maps = await db.query(tableName, where: '$columnId = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      if (maps.length > 1) {
        String s = maps.toString();
        print('more than one wordModel, $s');
      }
      return wordModelFromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<WordModel>> getAllWords(Database db) async {
    List<Map> maps = await db.query(tableName);
    List<WordModel> words = [];
    if (maps.isNotEmpty) {
      int i = 0;
      for (var map in maps) {
        print(map);
        WordModel model = wordModelFromMap(map);
        words.add(model);
        print(words[i++]);
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
}
