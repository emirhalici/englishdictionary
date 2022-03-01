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

  Map<String, String> toMap() {
    return <String, String>{
      'id': id.toString(),
      'word': word,
      'definition': definition,
      'type': type,
      'example': example,
    };
  }
}

WordModel wordModelFromMap(Map<dynamic, dynamic> map) {
  String? id = map['id'];
  id ??= '0';
  return WordModel(
    id: int.parse(id),
    word: map['word'].toString(),
    definition: map['definition'].toString(),
    type: map['type'].toString(),
    example: map['example'].toString(),
  );
}

class QuizModel {
  int answerIndex;
  List<WordModel> options;

  QuizModel({required this.options, required this.answerIndex});
}
