class WordModel {
  int id;
  String word;
  String definition;
  String type;
  String example;

  WordModel({required this.id, required this.word, required this.definition, required this.type, required this.example});

  @override
  String toString() {
    return "WordModel{" "id=" +
        id.toString() +
        ", word='" +
        word +
        '\'' +
        ", type='" +
        type +
        '\'' +
        ", definition='" +
        definition +
        '\'' +
        ", example='" +
        example +
        '\'' +
        '}';
  }
}

class QuizModel {
  int answerIndex;
  List<WordModel> options;

  QuizModel({required this.options, required this.answerIndex});
}
