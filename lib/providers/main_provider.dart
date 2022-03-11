import 'package:english_dictionary/models/word_model.dart';
import 'package:english_dictionary/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class MainProvider with ChangeNotifier {
  List<WordModel> _wordList = [];
  List<WordModel> get wordList => _wordList;

  void refresh() async {
    WordsDatabaseHelper helper = WordsDatabaseHelper();
    String path = await helper.getDatabasePath();
    Database db = await helper.open(path);
    _wordList = await helper.getAllWords(db);
    print('new word list: ' + _wordList.toString());
    helper.close(db);
    notifyListeners();
  }

  void delete(WordModel wordModel) async {
    WordsDatabaseHelper helper = WordsDatabaseHelper();
    String path = await helper.getDatabasePath();
    Database db = await helper.open(path);
    await helper.delete(db, wordModel.id);
    _wordList = await helper.getAllWords(db);
    print('new word list: ' + _wordList.toString());

    helper.close(db);
    notifyListeners();
  }

  void insert(WordModel wordModel) async {
    WordsDatabaseHelper helper = WordsDatabaseHelper();
    String path = await helper.getDatabasePath();
    Database db = await helper.open(path);
    WordModel newW = await helper.insert(db, wordModel);
    int id = newW.id;
    print('inserted word with id:$id');
    _wordList = await helper.getAllWords(db);
    print('new word list: ' + _wordList.toString());
    helper.close(db);
    notifyListeners();
  }
}
