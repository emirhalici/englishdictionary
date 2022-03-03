import 'package:english_dictionary/components/word_card_list.dart';
import 'package:english_dictionary/utils/api_helper.dart';
import 'package:english_dictionary/utils/objects.dart';
import 'package:english_dictionary/screens/word_details_page.dart';
import 'package:english_dictionary/themes.dart';
import 'package:flutter/material.dart';

class AddWordPage extends StatefulWidget {
  const AddWordPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AddWordPageState createState() => _AddWordPageState();
}

//
class _AddWordPageState extends State<AddWordPage> {
  final TextEditingController controller = TextEditingController();
  List<Widget> _cardList = [];

  void addCardsToList(List<WordModel> words) {
    List<Widget> wordCards = [];
    for (final word in words) {
      wordCards.add(
        WordListCard(
          wordModel: word,
          onPress: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => WordDetailsPage(wordModel: word)));
          },
        ),
      );
    }
    _cardList = wordCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Dictionary'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Expanded(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 26, top: 16, right: 26, bottom: 26),
                    child: Text(
                      'Search Word',
                      style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 36),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: TextField(
                      controller: controller,
                      decoration: textFieldDecorationWithHint(context, 'Enter the word you\'re looking for', 'i.e apple'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: button2(context, Theme.of(context), 8),
                              onPressed: () async {
                                String inputText = controller.text;
                                try {
                                  var response = await ApiHelper().searchWord(inputText);
                                  List<WordModel> words = ApiHelper().getWordModelsFromResponse(response);
                                  setState(() {
                                    addCardsToList(words);
                                  });
                                  //WordModel word = words.first;
                                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => WordDetailsPage(wordModel: word)));
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
                            width: 12,
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
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemCount: _cardList.length,
                    itemBuilder: (context, index) {
                      return _cardList[index];
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
