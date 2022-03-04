import 'package:english_dictionary/components/word_list_card.dart';
import 'package:english_dictionary/utils/objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Dictionary'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          children: [
            WordListCard(
              wordModel: WordModel(
                  id: -1,
                  word: 'nepotism',
                  definition: 'the th power or influence of favouring  reatives or friends, especially  by giving them jobs.',
                  type: 'noun',
                  example: 'example sentence'),
            ),
            WordListCard(
              wordModel: WordModel(
                  id: -1,
                  word: 'nepotism',
                  definition:
                      'the practice among those with power or influence of favouring  relatives or friends, especially  by giving them jobs.',
                  type: 'noun',
                  example: 'example sentence'),
            ),
            WordListCard(
              wordModel: WordModel(
                id: -1,
                word: 'demise',
                definition: 'a person\'s death',
                type: 'noun',
                example: 'Mr. James\' demise has upset all of us.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
