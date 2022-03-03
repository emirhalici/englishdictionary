import 'package:english_dictionary/models/apiHelper.dart';
import 'package:english_dictionary/models/objects.dart';
import 'package:english_dictionary/screens/word_details_page.dart';
import 'package:english_dictionary/themes.dart';
import 'package:flutter/material.dart';

class AddWordPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final String title;
  AddWordPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Dictionary'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            Text(
              'Search Word',
              style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 36),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 26),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter the word you\'re looking for',
                hintText: 'i.e apple',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: button2(context, Theme.of(context), 8),
                      onPressed: () async {
                        String inputText = controller.text;
                        var response = await ApiHelper().searchWord(inputText);
                        try {
                          List<WordModel> words = ApiHelper().getWordModelsFromResponse(response);
                          WordModel word = words.first;
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => WordDetailsPage(wordModel: word)));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error while searching for word.'),
                              duration: Duration(milliseconds: 1500),
                            ),
                          );
                        }
                      },
                      child: const Text('Search Word', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      style: button3(context, Theme.of(context), 8),
                      onPressed: () {},
                      child: const Text('Add Manually', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
