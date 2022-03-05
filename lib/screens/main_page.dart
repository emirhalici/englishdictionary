import 'package:english_dictionary/components/word_list_card.dart';
import 'package:english_dictionary/screens/word_details_page.dart';
import 'package:english_dictionary/utils/database_helper.dart';
import 'package:english_dictionary/utils/objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite/sqlite_api.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<WordListCard> cards = [];

  void getWords() async {
    WordsDatabaseProvider helper = WordsDatabaseProvider();
    String path = await helper.getDatabasePath();
    Database db = await helper.open(path);
    List<WordModel> words = await helper.getAllWords(db);
    print(words.toString());
    helper.close(db);
    setState(() {
      for (var word in words) {
        cards.add(WordListCard(
          wordModel: word,
          onPress: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => WordDetailsPage(wordModel: word)));
          },
        ));
      }
    });
  }

  @override
  void initState() {
    getWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // floatingActionButton: FloatingActionButton(onPressed: () async {
        //   print('button pressed');
        //   WordsDatabaseProvider helper = WordsDatabaseProvider();
        //   String path = await helper.getDatabasePath();
        //   Database db = await helper.open(path);
        //   WordModel word = await helper.insert(
        //       db,
        //       WordModel(
        //           id: -1,
        //           word: 'nepotism',
        //           definition:
        //               'the practice among those with power or influence of favouring  relatives or friends, especially  by giving them jobs.',
        //           type: 'noun',
        //           example: 'example sentence'));
        //   print(word.toString());
        //   WordModel? newWord = await helper.getWord(db, word.id);
        //   print(newWord.toString());
        //   helper.close(db);
        // }),
        SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          children: cards,
        ),
      ),
    );
  }
}

// [

//             WordListCard(
//               wordModel: WordModel(
//                   id: -1,
//                   word: 'nepotism',
//                   definition: 'the th power or influence of favouring  reatives or friends, especially  by giving them jobs.',
//                   type: 'noun',
//                   example: 'example sentence'),
//             ),
//             WordListCard(
//               wordModel: WordModel(
//                   id: -1,
//                   word: 'nepotism',
//                   definition:
//                       'the practice among those with power or influence of favouring  relatives or friends, especially  by giving them jobs.',
//                   type: 'noun',
//                   example: 'example sentence'),
//             ),
//             WordListCard(
//               wordModel: WordModel(
//                 id: -1,
//                 word: 'demise',
//                 definition: 'a person\'s death',
//                 type: 'noun',
//                 example: 'Mr. James\' demise has upset all of us.',
//               ),
//             ),
//           ],