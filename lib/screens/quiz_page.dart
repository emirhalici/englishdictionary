import 'package:english_dictionary/models/quiz_model.dart';
import 'package:english_dictionary/providers/quiz_provider.dart';
import 'package:english_dictionary/screens/quiz_end_page.dart';
import 'package:english_dictionary/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<int> buttonStates = [0, 0, 0, 0];
  bool isActive = true;
  bool isNextButtonVisible = true;
  int choice = -1;
  @override
  Widget build(BuildContext context) {
    final bool isReversed = context.watch<QuizProvider>().isAnswerQuestion;
    int currentIndex = context.watch<QuizProvider>().currentIndex;
    int questionCount = context.watch<QuizProvider>().questionCount;
    QuizModel currentQuestion = context.watch<QuizProvider>().getQuizModel();

    print('current at $currentIndex+1th question');

    // 0 for unanswered, 1 for correct, 2 for wrong answers, 3 for disabled.

    void updateButtons(int buttonIndex) {
      setState(() {
        bool isCorrect = currentQuestion.answerIndex == buttonIndex;
        buttonStates[0] = currentQuestion.answerIndex == 0 ? 1 : 0;
        buttonStates[1] = currentQuestion.answerIndex == 1 ? 1 : 0;
        buttonStates[2] = currentQuestion.answerIndex == 2 ? 1 : 0;
        buttonStates[3] = currentQuestion.answerIndex == 3 ? 1 : 0;
        buttonStates[buttonIndex] = isCorrect ? 1 : 2;
        isActive = false;
      });
    }

    void resetButtons() {
      setState(() {
        buttonStates[0] = 0;
        buttonStates[1] = 0;
        buttonStates[2] = 0;
        buttonStates[3] = 0;
      });
    }

    ButtonStyle buttonStyle(int index) {
      int state = buttonStates[index];
      if (state == 0) {
        return questionButtonStyle(context);
      } else if (state == 1) {
        return correctButtonStyle(context);
      } else if (state == 2) {
        return wrongButtonStyle(context);
      } else {
        return questionButtonStyle(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: const Text("Quiz"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FAProgressBar(
                currentValue: (currentIndex / questionCount * 100).toInt(),
                maxValue: 100,
                size: 5,
                animatedDuration: const Duration(milliseconds: 100),
                progressColor: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primaryContainer,
              ),
              // LinearProgressIndicator(
              //   color: Theme.of(context).brightness == Brightness.dark
              //       ? Theme.of(context).colorScheme.secondary
              //       : Theme.of(context).colorScheme.primaryContainer,
              //   backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).colorScheme.background,
              //   minHeight: 5,
              //   value: (currentIndex) / questionCount,
              // ),
              Padding(
                padding: EdgeInsets.only(top: 32.h, left: 20.w, right: 20.w),
                child: Text(
                    isReversed
                        ? currentQuestion.options[currentQuestion.answerIndex].definition
                        : currentQuestion.options[currentQuestion.answerIndex].word,
                    textAlign: TextAlign.center,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                          fontSize: 24.sp,
                        )),
              ),
            ],
          ), // top part
          Padding(
            padding: EdgeInsets.only(bottom: 22.h, left: 38.w, right: 38.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isActive) {
                        updateButtons(0);
                        isActive = false;
                        choice = 0;
                      }
                    });
                  },
                  style: buttonStyle(0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      isReversed ? currentQuestion.options[0].word : currentQuestion.options[0].definition,
                      style: quizButtonStyle(Theme.of(context)),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isActive) {
                        updateButtons(1);
                        isActive = false;
                        choice = 1;
                      }
                    });
                  },
                  style: buttonStyle(1),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      isReversed ? currentQuestion.options[1].word : currentQuestion.options[1].definition,
                      style: quizButtonStyle(Theme.of(context)),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isActive) {
                        updateButtons(2);
                        isActive = false;
                        choice = 2;
                      }
                    });
                  },
                  style: buttonStyle(2).copyWith(
                    maximumSize: MaterialStateProperty.all(
                      Size(
                        double.infinity,
                        MediaQuery.of(context).size.height * 0.1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      isReversed ? currentQuestion.options[2].word : currentQuestion.options[2].definition,
                      style: quizButtonStyle(Theme.of(context)),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isActive) {
                        updateButtons(3);
                        isActive = false;
                        choice = 3;
                      }
                    });
                  },
                  style: buttonStyle(3),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      isReversed ? currentQuestion.options[3].word : currentQuestion.options[3].definition,
                      style: quizButtonStyle(Theme.of(context)),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                SizedBox(height: 36.h),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: button2(context, Theme.of(context), 8),
                          onPressed: () {
                            context.read<QuizProvider>().nextQuestion(choice);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuizEndPage()));
                          },
                          child: Text(
                            'End Test',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isNextButtonVisible,
                        child: SizedBox(width: 20.w),
                      ),
                      Visibility(
                        visible: isNextButtonVisible,
                        child: Expanded(
                          child: ElevatedButton(
                            style: button2(context, Theme.of(context), 8),
                            onPressed: () {
                              if (questionCount == currentIndex + 2) {
                                setState(() {
                                  isNextButtonVisible = false;
                                });
                              }
                              isActive = true;
                              context.read<QuizProvider>().nextQuestion(choice);
                              resetButtons();
                              choice = -1;
                            },
                            child: Text(
                              'Next',
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ), // bottom answer buttons
        ],
      ),
    );
  }
}
