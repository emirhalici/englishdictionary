import 'package:english_dictionary/utils/objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WordListCard extends StatelessWidget {
  final Function()? onPress;
  final WordModel wordModel;
  const WordListCard({Key? key, required this.wordModel, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).brightness == Brightness.light ? Colors.white : const Color(0xAA2E3236);
    Color textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    bool drowShadow = Theme.of(context).brightness == Brightness.light;
    Color shadowColor = drowShadow ? textColor.withOpacity(0.12) : Colors.transparent;

    return Container(
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
                    style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 20.sp, color: textColor, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w, left: 12.w),
                  child: Text(
                    wordModel.word,
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: textColor),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
                  child: Text(
                    wordModel.definition,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 16.sp, color: textColor.withOpacity(0.7)),
                  ),
                ),
              ),
            ],
          ),
          onTap: onPress,
        ),
      ),
    );
  }
}
