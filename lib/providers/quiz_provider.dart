import 'package:english_dictionary/models/quiz_model.dart';
import 'package:english_dictionary/models/word_model.dart';
import 'package:english_dictionary/utils/quiz_helper.dart';
import 'package:flutter/material.dart';

class QuizProvider with ChangeNotifier {
  List<QuizModel> quizList = [];
  List<WordModel> wrongWords = [];
  List<WordModel> allWords = [];
  List<WordModel> selectedWords = [];
  bool isAnswerQuestion = false;

  void setSelectedWords(List<WordModel> words) {
    allWords = words;
    notifyListeners();
  }

  void filterWords(int size, List<String> types) {
    selectedWords = [];
    // first filter by types
    for (final word in allWords) {
      if (types.contains(word.type)) {
        selectedWords.add(word);
      }
    }

    // then filter by size
    if (selectedWords.length < size) {
      print('selectedWords > size');
    } else {
      //selectedWords.removeRange(0, size - 1);
    }

    notifyListeners();
  }

  void initializeList(int size) {
    int optionSize = 4;
    quizList = QuizHelper().getQuizModels(selectedWords, optionSize);
    if (quizList.length > size) {
      quizList.removeRange(size - 1, quizList.length - 1);
    }
  }

  void setQuizStatus(bool isQuestionAnswer) {
    isAnswerQuestion = isQuestionAnswer;
  }

  int currentIndex = 0;
  late int maxIndex = quizList.length - 1;

  late int questionCount = quizList.length;
  int trueAnswer = 0;
  int wrongAnswer = 0;
  bool isQuizOver = false;

  QuizModel getQuizModel() {
    if (currentIndex > maxIndex) {
      return quizList[maxIndex];
    } else {
      return quizList[currentIndex];
    }
  }

  void nextQuestion(int choice) {
    QuizModel current = getQuizModel();
    bool isCorrect = current.answerIndex == choice;
    if (isCorrect) {
      trueAnswer++;
    } else if (!isCorrect || (choice > 3 || choice < 0)) {
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

  void resetEverything() {
    trueAnswer = 0;
    wrongAnswer = 0;
    isQuizOver = false;
    quizList = [];
    wrongWords = [];
    allWords = [];
    selectedWords = [];
    isAnswerQuestion = false;
    currentIndex = 0;
  }
}
