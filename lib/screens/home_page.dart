import 'package:english_dictionary/components/empty_main_page.dart';
import 'package:english_dictionary/components/word_list_card.dart';
import 'package:english_dictionary/screens/word_details_page.dart';
import 'package:english_dictionary/utils/database_helper.dart';
import 'package:english_dictionary/utils/objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite/sqlite_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WordListCard> cards = [];

  void getWords() async {
    WordsDatabaseProvider helper = WordsDatabaseProvider();
    String path = await helper.getDatabasePath();
    Database db = await helper.open(path);
    List<WordModel> words = await helper.getAllWords(db);
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('English Dictionary'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Material(
        color: Colors.transparent,
        child: cards.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: StaggeredGrid.count(
                  crossAxisCount: cards.length,
                  children: cards,
                ),
              )
            : const EmptyMainPage(),
      ),
    );
  }
}
