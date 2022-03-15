import 'package:english_dictionary/components/empty_quiz_page.dart';
import 'package:english_dictionary/models/word_model.dart';
import 'package:english_dictionary/providers/quiz_provider.dart';
import 'package:english_dictionary/screens/quiz_page.dart';
import 'package:english_dictionary/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/main_provider.dart';

class QuizStartPage extends StatefulWidget {
  const QuizStartPage({Key? key}) : super(key: key);

  @override
  State<QuizStartPage> createState() => _QuizStartPageState();
}

class _QuizStartPageState extends State<QuizStartPage> {
  int desiredQuizSize = 0;
  bool isQuizReversed = false;
  List<String> allTypes = [];
  List<String> typeFilter = [];
  int maxQuizSize = 99;
  bool isFirst = true;

  void buildChips() async {
    // if (allTypes.isEmpty) {
    //   List<String> types = await context.watch<MainProvider>().getWordTypes();
    //   allTypes.addAll(types);
    //   typeFilter.addAll(types);
    // }
    allTypes = await context.watch<MainProvider>().getWordTypes();
    if (isFirst) {
      typeFilter.addAll(allTypes);
      isFirst = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    buildChips();
    maxQuizSize = context.watch<MainProvider>().maxQuizSize(typeFilter);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        child: allTypes.isEmpty
            ? const EmptyQuizPage()
            : Stack(
                fit: StackFit.expand,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 32.h),
                      child: ElevatedButton(
                        style: button2(context, Theme.of(context), 24),
                        onPressed: () async {
                          // input validation
                          if (desiredQuizSize <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                content: const Text("Please choose a bigger quiz size."),
                              ),
                            );
                          } else {
                            // move to the quiz page
                            List<WordModel> words = context.read<MainProvider>().wordList;
                            context.read<QuizProvider>().resetEverything();
                            context.read<QuizProvider>().setSelectedWords(words);
                            context.read<QuizProvider>().filterWords(desiredQuizSize, typeFilter);
                            context.read<QuizProvider>().initializeList(desiredQuizSize);
                            context.read<QuizProvider>().setQuizStatus(isQuizReversed);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuizPage()));
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Text('Start', style: TextStyle(fontSize: 24.sp)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 20.h, right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Quiz',
                          style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 36.sp),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reverse the quiz format',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w300),
                            ),
                            Checkbox(
                              fillColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
                              value: isQuizReversed,
                              onChanged: (newValue) {
                                setState(() {
                                  isQuizReversed = newValue ?? false;
                                });
                              },
                            ),
                          ],
                        ),
                        const Divider(thickness: 2, height: 16),
                        Text(
                          'Quiz size',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w300),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Slider.adaptive(
                                min: 0,
                                max: maxQuizSize.toDouble() <= 1 ? 1 : maxQuizSize.toDouble(),
                                value: desiredQuizSize.toDouble(),
                                activeColor: Theme.of(context).colorScheme.primary,
                                onChanged: (newValue) {
                                  setState(() {
                                    desiredQuizSize = newValue.toInt();
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              '$desiredQuizSize/$maxQuizSize',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        const Divider(thickness: 2, height: 16),
                        Text(
                          'Filter word type',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w300),
                        ),
                        Wrap(
                          spacing: 8.w,
                          children: List<Widget>.generate(
                            allTypes.length,
                            (int idx) {
                              return FilterChip(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: chipBorderColor(context), width: 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: Colors.transparent,
                                  selectedColor: Colors.transparent,
                                  label: Text(
                                    allTypes[idx],
                                    style: const TextStyle(),
                                  ),
                                  selected: typeFilter.contains(allTypes[idx]),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        if (!typeFilter.contains(allTypes[idx])) {
                                          typeFilter.add(allTypes[idx]);
                                          desiredQuizSize = 0;
                                        }
                                      } else {
                                        if (typeFilter.length == 1) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Theme.of(context).colorScheme.primary,
                                              content: const Text("At least 1 type should be selected."),
                                            ),
                                          );
                                        } else {
                                          typeFilter.remove(allTypes[idx]);
                                          desiredQuizSize = 0;
                                        }
                                      }
                                    });
                                  });
                            },
                          ).toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String title;
  final Function(bool)? onSelect;
  final bool isSelected;
  const FilterChipWidget({Key? key, required this.title, required this.onSelect, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(title),
      selected: isSelected,
      onSelected: onSelect,
    );
  }
}
