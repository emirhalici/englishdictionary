import 'package:english_dictionary/themes.dart';
import 'package:english_dictionary/utils/objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WordSearchCard extends StatelessWidget {
  final Function()? onPress;
  final WordModel wordModel;
  const WordSearchCard({Key? key, required this.wordModel, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).brightness == Brightness.light ? Colors.white : const Color(0xAA2E3236);
    Color textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    bool drowShadow = Theme.of(context).brightness == Brightness.light;
    Color shadowColor = drowShadow ? textColor.withOpacity(0.12) : Colors.transparent;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 16.0,
            spreadRadius: 0.0,
            offset: const Offset(0, 0),
          )
        ]),
        child: Card(
          color: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.w, left: 12.w, top: 12.h),
                    child: Text(
                      wordModel.type,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 20.sp, color: textColor),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.h),
                    child: Text(
                      wordModel.definition,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 16.sp, color: textColor.withOpacity(0.7)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
                    child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: 'e.g. ',
                            style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 14.sp, color: textColor.withOpacity(0.7)),
                          ),
                          TextSpan(
                            text: wordModel.example,
                            style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 14.sp, color: textColor.withOpacity(0.7)),
                          ),
                        ])),
                  ),
                )
              ],
            ),
            onTap: onPress,
          ),
        ),
      ),
    );
  }
}
