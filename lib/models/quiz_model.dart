import 'package:english_dictionary/models/word_model.dart';

class QuizModel {
  int answerIndex;
  List<WordModel> options;

  QuizModel({required this.options, required this.answerIndex});
}
