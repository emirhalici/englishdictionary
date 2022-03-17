import 'dart:math';
import 'package:english_dictionary/models/quiz_model.dart';
import 'package:english_dictionary/models/word_model.dart';

class QuizHelper {
  List<QuizModel> getQuizModels(List<WordModel> selectedWords, int optionSize) {
    List<WordModel> newWords = [];
    newWords.addAll(selectedWords);
    newWords.shuffle();

    List<QuizModel> quizList = [];
    for (WordModel word in newWords) {
      Random random = Random();
      List<WordModel> options = [];
      while (options.length < optionSize) {
        int randomIndex = random.nextInt(selectedWords.length);
        WordModel nextWord = selectedWords[randomIndex];
        while (options.contains(nextWord) || word.word == nextWord.word) {
          randomIndex = random.nextInt(selectedWords.length);
          nextWord = selectedWords[randomIndex];
        }
        options.add(nextWord);
      }
      int answerIndex = random.nextInt(options.length);
      options.insert(answerIndex, word);
      //print(answerIndex.toString() + '   =>  ' + options[0].word + ' ' + options[1].word + ' ' + options[2].word + ' ' + options[3].word);
      QuizModel model = QuizModel(options: options, answerIndex: answerIndex);
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
