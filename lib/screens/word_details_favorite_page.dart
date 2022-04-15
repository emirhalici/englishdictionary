import 'dart:io';

import 'package:english_dictionary/components/word_details_card.dart';
import 'package:english_dictionary/models/word_model.dart';
import 'package:english_dictionary/providers/main_provider.dart';
import 'package:english_dictionary/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

String capitalize(String s) {
  return s[0].toUpperCase() + s.substring(1);
}

class WordDetailsFavoritePage extends StatelessWidget {
  final WordModel wordModel;
  const WordDetailsFavoritePage({Key? key, required this.wordModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void deleteItem(WordModel model) {
      context.read<MainProvider>().deleteFavorite(wordModel);
      Navigator.of(context).pop();
    }

    Color exampleTextColor =
        Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.48) : Colors.white.withOpacity(0.6);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Word Details'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.w, bottom: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capitalize(wordModel.word),
                  style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 36.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20.h),
                WordDetailsCard(type: wordModel.type, definition: capitalize(wordModel.definition)),
                SizedBox(height: 26.h),
                Text(
                  wordModel.example.toLowerCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: exampleTextColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        primary: Theme.of(context).brightness == Brightness.dark ? darkTextColor : lightTextColor,
                        side: BorderSide(color: Colors.red.shade800, width: 2.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      // ask for confirmation
                      if (Platform.isIOS) {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) => CupertinoAlertDialog(
                              title: const Text("Remove word?"),
                              content: Text("The word ${wordModel.word} will be removed from favorites"),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text('Remove'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    deleteItem(wordModel);
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
                            title: const Text("Delete word?"),
                            content: Text("The word ${wordModel.word} will be deleted from your vocabulary"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    deleteItem(wordModel);
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Text(
                        'Remove from favorites',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.red.shade800),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
