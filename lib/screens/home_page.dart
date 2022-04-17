import 'package:english_dictionary/components/empty_main_page.dart';
import 'package:english_dictionary/components/word_list_card.dart';
import 'package:english_dictionary/models/word_model.dart';
import 'package:english_dictionary/providers/main_provider.dart';
import 'package:english_dictionary/screens/word_details_favorite_page.dart';
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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
          //context.read<MainProvider>().scrollToTop();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => WordDetailsPage(wordModel: word)));
        },
      ));
    }

    List<WordModel> favoriteWords = context.watch<MainProvider>().favoriteWordList;
    List<WordListCard> favoriteCards = [];
    for (var word in favoriteWords) {
      favoriteCards.add(WordListCard(
        wordModel: word,
        onPress: () {
          //context.read<MainProvider>().scrollToTop();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => WordDetailsFavoritePage(wordModel: word)));
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
              ? DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          labelPadding: const EdgeInsets.only(right: 20, left: 20),
                          isScrollable: true,
                          labelColor: Theme.of(context).colorScheme.primary,
                          unselectedLabelColor: Colors.grey,
                          indicator: CircleTabIndicator(color: Theme.of(context).colorScheme.primary, radius: 4),
                          tabs: const [
                            Tab(text: 'All Words'),
                            Tab(text: 'Favorite Words'),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        ),
                        width: double.infinity,
                        height: 1,
                      ),
                      Expanded(
                        child: TabBarView(
                          //controller: widget.tabController,
                          children: [
                            cards.isEmpty
                                ? EmptyMainPage(message: "Go and add some vocabulary.")
                                : SingleChildScrollView(
                                    controller: context.watch<MainProvider>().controller,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                      child: StaggeredGrid.count(
                                        crossAxisCount: 2,
                                        children: cards,
                                      ),
                                    ),
                                  ),
                            favoriteCards.isEmpty
                                ? EmptyMainPage(message: "Go and add some words to your favorites.")
                                : SingleChildScrollView(
                                    controller: context.watch<MainProvider>().controller2,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                      child: StaggeredGrid.count(
                                        crossAxisCount: 2,
                                        children: favoriteCards,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : EmptyMainPage(message: "Go and add some vocabulary."),
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius}) : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset = offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius - 5);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
