import 'package:english_dictionary/components/word_list_card.dart';
import 'package:english_dictionary/screens/word_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';

class QuizEndPage extends StatelessWidget {
  const QuizEndPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int qCount = context.read<QuizProvider>().questionCount;
    int cCount = context.read<QuizProvider>().trueAnswer;
    int wCount = context.read<QuizProvider>().wrongAnswer;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Statistics',
                    style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 36.sp),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 22.h),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.read<QuizProvider>().questionCount.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 36.sp,
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              'questions',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13.sp,
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: const VerticalDivider(
                            thickness: 2,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.read<QuizProvider>().trueAnswer.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 36.sp,
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              'correct answer',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13.sp,
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: const VerticalDivider(
                            thickness: 2,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.read<QuizProvider>().wrongAnswer.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 36.sp,
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              'wrong answer',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13.sp,
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 26.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        (cCount / qCount * 100).toInt().toString() + '% ',
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w500,
                          textBaseline: TextBaseline.alphabetic,
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        ' success rate',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          textBaseline: TextBaseline.alphabetic,
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: context.watch<QuizProvider>().wrongWords.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: WordListCard(
                      wordModel: context.watch<QuizProvider>().wrongWords[index],
                      onPress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WordDetailsPage(wordModel: context.watch<QuizProvider>().wrongWords[index])));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
