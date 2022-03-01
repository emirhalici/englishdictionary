import 'dart:convert';
import 'objects.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  Future<http.Response> searchWord(String word) async {
    try {
      var url = Uri.parse("https://owlbot.info/api/v4/dictionary/$word");
      Map<String, String> header = {"Authorization": "Token 0079c3f37f84c622aaf92b8ea65159aacf23a7ed"};
      http.Response response = await http.get(url, headers: header);
      return response;
    } catch (e) {
      throw Exception('Failed to request network call');
    }
  }

  List<WordModel> getWordModelsFromResponse(http.Response response) {
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<WordModel> words = <WordModel>[];
      for (var item in body['definitions']) {
        WordModel w =
            WordModel(id: -1, word: body['word'], definition: item['definition'], type: item['type'], example: item['example'] ?? 'null');
        words.add(w);
      }
      return words;
    } else {
      throw Exception('Bad response');
    }
  }
}
