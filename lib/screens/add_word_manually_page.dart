import 'package:english_dictionary/models/word_model.dart';
import 'package:english_dictionary/providers/main_provider.dart';
import 'package:english_dictionary/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddWordManuallyPage extends StatelessWidget {
  final TextEditingController controllerWord = TextEditingController();
  final TextEditingController controllerType = TextEditingController();
  final TextEditingController controllerDefinition = TextEditingController();
  final TextEditingController controllerExample = TextEditingController();
  AddWordManuallyPage({Key? key}) : super(key: key);

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
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: <Widget>[
            SizedBox(height: 16.h),
            Text(
              'Add Word',
              style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 36.sp),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 22.h),
            TextField(
              controller: controllerWord,
              decoration: textFieldDecorationWithHint(context, 'Enter word', 'i.e apple'),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: controllerType,
              decoration: textFieldDecoration(context, 'Enter word type'),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: controllerDefinition,
              minLines: 2,
              maxLines: 3,
              textAlignVertical: TextAlignVertical.center,
              decoration: textFieldDecoration(context, 'Enter definition'),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: controllerExample,
              minLines: 1,
              maxLines: 3,
              decoration: textFieldDecoration(context, 'Enter an example sentence'),
            ),
            SizedBox(height: 16.h),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: button2(context, Theme.of(context), 8),
                      onPressed: () {
                        // add word
                        String word = controllerWord.text;
                        String type = controllerType.text;
                        String definition = controllerDefinition.text;
                        String example = controllerExample.text;

                        WordModel newWord = WordModel(id: -1, word: word, definition: definition, type: type, example: example);

                        context.read<MainProvider>().insert(newWord);
                        Navigator.pop(context);
                      },
                      child: Text('Add Word', style: TextStyle(fontSize: 14.sp)),
                    ),
                  ),
                  SizedBox(width: 16.h),
                  Expanded(
                    child: TextButton(
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
                        Navigator.pop(context);
                      },
                      child: Text('Cancel', style: TextStyle(fontSize: 14.sp)),
                    ),
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
