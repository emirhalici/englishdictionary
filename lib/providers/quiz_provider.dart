import 'package:english_dictionary/models/quiz_model.dart';
import 'package:english_dictionary/models/word_model.dart';
import 'package:english_dictionary/utils/quiz_helper.dart';
import 'package:flutter/material.dart';

class QuizProvider with ChangeNotifier {
  List<QuizModel> quizList;
  List<WordModel> wrongWords = [];

  QuizProvider({required this.quizList});

  int currentIndex = 0;
  late int maxIndex = quizList.length - 1;

  late int questionCount = quizList.length;
  int trueAnswer = 0;
  int wrongAnswer = 0;
  bool isQuizOver = false;

  QuizModel getQuizModel() {
    return quizList[currentIndex];
  }

  void nextQuestion(int choice) {
    QuizModel current = getQuizModel();
    bool isCorrect = QuizHelper().isCorrectAnswer(current, choice);
    if (isCorrect) {
      trueAnswer++;
    } else if (!isCorrect && (choice < 4 && choice >= 0)) {
      wrongAnswer++;
    }

    // if answer is not correct or blank answer, add to list
    if (!isCorrect || (choice > 3 || choice < 0)) {
      wrongWords.add(current.options[current.answerIndex]);
    }

    currentIndex++;
    if (currentIndex > maxIndex) {
      isQuizOver = true;
    }
    notifyListeners();
  }

  int successRate() {
    double rate = trueAnswer / questionCount * 100;
    return rate.toInt();
  }
}
