import 'dart:math';

import 'package:english_dictionary/utils/objects.dart';

class QuizHelper {
  List<QuizModel> getQuizModels(List<WordModel> selectedWords, int size, int optionSize) {
    List<WordModel> newWords = [];
    newWords.addAll(selectedWords);
    newWords.shuffle();
    newWords.removeRange(size, selectedWords.length - 1);

    List<QuizModel> quizList = [];

    for (WordModel word in newWords) {
      Random random = Random();
      List<WordModel> options = [];
      while (options.length < optionSize) {
        int randomIndex = random.nextInt(selectedWords.length);
        WordModel nextWord = selectedWords[randomIndex];
        while (options.contains(nextWord)) {
          randomIndex = random.nextInt(selectedWords.length);
          nextWord = selectedWords[randomIndex];
        }
        options.add(nextWord);
      }
      int answerIndex = random.nextInt(options.length + 1);
      options.insert(answerIndex, word);
      quizList.add(QuizModel(options: options, answerIndex: answerIndex));
    }
    return quizList;
  }

  int getMaxQuizSize(List<WordModel> selectedWords, int optionSize) {
    return selectedWords.length - optionSize - 1;
  }

  bool isCorrectAnswer(QuizModel quizModel, int selectedAnwser) {
    return quizModel.answerIndex == selectedAnwser;
  }
}