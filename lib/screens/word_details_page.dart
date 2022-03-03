import 'package:english_dictionary/components/wordCard.dart';
import 'package:english_dictionary/models/objects.dart';
import 'package:english_dictionary/themes.dart';
import 'package:flutter/material.dart';

String capitalize(String s) {
  return s[0].toUpperCase() + s.substring(1);
}

class WordDetailsPage extends StatelessWidget {
  final WordModel wordModel;
  const WordDetailsPage({Key? key, required this.wordModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Details'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            capitalize(wordModel.word),
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 36),
          ),
          WordCard(type: wordModel.type, definition: capitalize(wordModel.definition)),
          const SizedBox(height: 10),
          Text(
            wordModel.example.toLowerCase(),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(color: const Color(0xAA62717D)),
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: button2(context, Theme.of(context), 12).copyWith(),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Add word to favourites',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: OutlinedButton(
                    style: button3(context, Theme.of(context), 12).copyWith(),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Delete word',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
