import 'package:english_dictionary/components/word_search_card.dart';
import 'package:english_dictionary/screens/add_word_manually_page.dart';
import 'package:english_dictionary/utils/api_helper.dart';
import 'package:english_dictionary/utils/database_helper.dart';
import 'package:english_dictionary/utils/objects.dart';
import 'package:english_dictionary/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite/sqflite.dart';

class AddWordPage extends StatefulWidget {
  const AddWordPage({Key? key}) : super(key: key);

  @override
  _AddWordPageState createState() => _AddWordPageState();
}

class _AddWordPageState extends State<AddWordPage> {
  final TextEditingController controller = TextEditingController();
  List<Widget> _cardList = [];

  void addCardsToList(List<WordModel> words) {
    List<Widget> wordCards = [];
    for (final word in words) {
      wordCards.add(
        WordSearchCard(
          wordModel: word,
          onPress: () async {
            WordsDatabaseProvider helper = WordsDatabaseProvider();
            String path = await helper.getDatabasePath();
            Database db = await helper.open(path);
            await helper.insert(db, word);
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
        automaticallyImplyLeading: true,
        title: const Text('Add Word'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, top: 16.h, right: 20.w, bottom: 22.h),
                      child: Text(
                        'Add Word',
                        style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 36.sp),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
                      child: TextField(
                        controller: controller,
                        decoration: textFieldDecorationWithHint(context, 'Enter the word you\'re looking for', 'i.e apple'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
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
                                child: Text(
                                  'Search Word',
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    primary: Theme.of(context).brightness == Brightness.dark ? darkTextColor : lightTextColor,
                                    side: BorderSide(
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? darkTextColor.withOpacity(0.5)
                                          : lightTextColor.withOpacity(0.5),
                                      width: 2.0,
                                    ),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddWordManuallyPage()));
                                },
                                child: Text(
                                  'Add Manually',
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
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
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemCount: _cardList.length,
                      itemBuilder: (context, index) {
                        return _cardList[index];
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}