import 'package:english_dictionary/components/empty_main_page.dart';
import 'package:english_dictionary/components/word_list_card.dart';
import 'package:english_dictionary/models/word_model.dart';
import 'package:english_dictionary/providers/main_provider.dart';
import 'package:english_dictionary/screens/word_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<MainProvider>().refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<WordModel> words = context.watch<MainProvider>().wordList;
    List<WordListCard> cards = [];
    for (var word in words) {
      cards.add(WordListCard(
        wordModel: word,
        onPress: () {
          context.read<MainProvider>().scrollToTop();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => WordDetailsPage(wordModel: word)));
        },
      ));
    }

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('English Dictionary'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Material(
          color: Colors.transparent,
          child: cards.isNotEmpty
              ? SingleChildScrollView(
                  controller: context.watch<MainProvider>().controller,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      children: cards,
                    ),
                  ),
                )
              : const EmptyMainPage(),
        ),
      ),
    );
  }
}
