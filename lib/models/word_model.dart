import 'package:english_dictionary/utils/database_helper.dart';

class WordModel {
  int id;
  String word;
  String definition;
  String type;
  String example;
  final String columnId = 'columnId';
  final String columnWord = 'columnWord';
  final String columnType = 'columnType';
  final String columnDefinition = 'columnDefinition';
  final String columnExample = 'columnExample';
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
      columnWord: word,
      columnDefinition: definition,
      columnType: type,
      columnExample: example,
    };
  }
}

WordModel wordModelFromMap(Map<dynamic, dynamic> map) {
  String? id = map[columnId].toString();
  return WordModel(
    id: int.parse(id),
    word: map[columnWord].toString(),
    definition: map[columnDefinition].toString(),
    type: map[columnType].toString(),
    example: map[columnExample].toString(),
  );
}
