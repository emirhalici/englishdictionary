import 'package:english_dictionary/models/word_model.dart';
import 'package:english_dictionary/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class MainProvider with ChangeNotifier {
  List<WordModel> _wordList = [];
  List<WordModel> _favoriteWordList = [];
  List<WordModel> get wordList => _wordList;
  List<WordModel> get favoriteWordList => _favoriteWordList;
  ScrollController controller = ScrollController();
  ScrollController controller2 = ScrollController();

  void scrollToTop() {
    // TEMPORARY FIX
    // TODO: FIX LATER
    try {
      controller.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } catch (e) {}
    try {
      controller2.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } catch (e) {}
  }

  void refresh() async {
    WordsDatabaseHelper helper = WordsDatabaseHelper();
    String path = await helper.getDatabasePath();
    Database db = await helper.open(path);
    _wordList = await helper.getAllWords(db);

    String pathFavorite = await helper.getFavoriteDatabasePath();
    Database dbFavorite = await helper.openFavorite(pathFavorite);
    _favoriteWordList = await helper.getAllFavoriteWords(dbFavorite);
    notifyListeners();
  }

  void delete(WordModel wordModel) async {
    WordsDatabaseHelper helper = WordsDatabaseHelper();
    String path = await helper.getDatabasePath();
    Database db = await helper.open(path);
    await helper.delete(db, wordModel.id);
    _wordList = await helper.getAllWords(db);
    notifyListeners();
  }

  void insert(WordModel wordModel) async {
    WordsDatabaseHelper helper = WordsDatabaseHelper();
    String path = await helper.getDatabasePath();
    Database db = await helper.open(path);
    await helper.insert(db, wordModel);

    _wordList = await helper.getAllWords(db);
    notifyListeners();
  }

  void insertFavorite(WordModel wordModel) async {
    WordsDatabaseHelper helper = WordsDatabaseHelper();
    String path = await helper.getFavoriteDatabasePath();
    Database db = await helper.openFavorite(path);
    await helper.insertFavorite(db, wordModel);

    _favoriteWordList = await helper.getAllFavoriteWords(db);
    notifyListeners();
  }

  void deleteFavorite(WordModel wordModel) async {
    WordsDatabaseHelper helper = WordsDatabaseHelper();
    String path = await helper.getFavoriteDatabasePath();
    Database db = await helper.openFavorite(path);
    await helper.deleteFavorite(db, wordModel.id);

    _favoriteWordList = await helper.getAllFavoriteWords(db);
    notifyListeners();
  }

  int maxQuizSize(List<String> types) {
    refresh();
    int count = 0;

    for (final word in wordList) {
      if (types.contains(word.type)) {
        count++;
      }
    }
    count -= 5;
    if (count < 0) {
      count = 0;
    }
    return count;
  }

  Future<List<String>> getWordTypes() async {
    WordsDatabaseHelper helper = WordsDatabaseHelper();
    String path = await helper.getDatabasePath();
    Database db = await helper.open(path);
    List<String> types = await helper.getWordTypes(db);
    return types;
  }
}
