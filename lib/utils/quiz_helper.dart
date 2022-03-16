import 'dart:math';
import 'package:english_dictionary/models/quiz_model.dart';
import 'package:english_dictionary/models/word_model.dart';

class QuizHelper {
  List<QuizModel> getQuizModels(List<WordModel> selectedWords, int optionSize) {
    List<WordModel> newWords = [];
    newWords.addAll(selectedWords);
    newWords.shuffle();

    List<QuizModel> quizList = [];
    int i = 1;
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
      int answerIndex = random.nextInt(options.length);
      print(answerIndex.toString());
      options.insert(answerIndex, word);
      QuizModel model = QuizModel(options: options, answerIndex: answerIndex);
      print(i.toString() + ' answer:' + model.answerIndex.toString());
      i++;
      quizList.add(model);
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
