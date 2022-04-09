import 'package:english_dictionary/components/word_search_card.dart';
import 'package:english_dictionary/models/word_model.dart';
import 'package:english_dictionary/providers/main_provider.dart';
import 'package:english_dictionary/screens/add_word_manually_page.dart';
import 'package:english_dictionary/utils/api_helper.dart';
import 'package:english_dictionary/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

class AddWordPage extends StatefulWidget {
  const AddWordPage({Key? key}) : super(key: key);

  @override
  _AddWordPageState createState() => _AddWordPageState();
}

class _AddWordPageState extends State<AddWordPage> {
  final TextEditingController controller = TextEditingController();
  List<Widget> _cardList = [];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.text == '') {
        setState(() {
          _cardList = [];
        });
      }
    });
  }

  void addCardsToList(List<WordModel> words) {
    List<Widget> wordCards = [];
    for (final word in words) {
      wordCards.add(
        WordSearchCard(
          wordModel: word,
          onPress: () async {
            // Show confirmation dialog with platform specific ui
            if (Platform.isIOS) {
              showCupertinoDialog(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Text("Add to vocabulary?"),
                    content: Text("The word ${word.word} will be added to your vocabulary"),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('Add'),
                        onPressed: () {
                          context.read<MainProvider>().insert(word);
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ]),
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("Add to vocabulary?"),
                  content: Text("The word ${word.word} will be added to your vocabulary"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          context.read<MainProvider>().insert(word);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel')),
                  ],
                ),
              );
            }
          },
        ),
      );
    }
    _cardList = wordCards;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
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
                                    String inputText = controller.text.trim();
                                    try {
                                      var response = await ApiHelper().searchWord(inputText);
                                      List<WordModel> words = ApiHelper().getWordModelsFromResponse(response);
                                      setState(() {
                                        addCardsToList(words);
                                      });
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('Error while searching for word.'),
                                          backgroundColor: Theme.of(context).colorScheme.primary,
                                          duration: const Duration(milliseconds: 1500),
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
      ),
    );
  }
}
