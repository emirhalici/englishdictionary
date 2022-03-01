import 'package:english_dictionary/models/objects.dart';
import 'package:sqflite/sqflite.dart';

const String tableName = 'tableWords';
const String columnId = 'columnId';
const String columnWord = 'columnWord';
const String columnType = 'columnType';
const String columnDefinition = 'columnDefinition';
const String columnExample = 'columnExample';

class WordsDatabaseProvider {
  late Database db;

  Future<String> getDatabasePath() async {
    var databasesPath = await getDatabasesPath();
    return databasesPath + tableName;
  }

  Future open(String path) async {
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            '''create table $tableName ($columnId integer primary key autoincrement, $columnWord text not null, $columnType text not null, $columnDefinition text not null, $columnExample text not null)''');
      },
    );
  }

  Future<WordModel> insert(WordModel wordModel) async {
    wordModel.id = await db.insert(tableName, wordModel.toMap());
    return wordModel;
  }

  Future<WordModel?> getWord(int id) async {
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

  Future<int> delete(int id) async {
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(WordModel wordModel) async {
    return await db.update(tableName, wordModel.toMap(), where: '$columnId = ?', whereArgs: [wordModel.id]);
  }

  Future close() async => db.close();
}
