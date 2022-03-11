import 'package:english_dictionary/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizStartPage extends StatefulWidget {
  const QuizStartPage({Key? key}) : super(key: key);

  @override
  State<QuizStartPage> createState() => _QuizStartPageState();
}

class _QuizStartPageState extends State<QuizStartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Quiz'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 32.h),
              child: ElevatedButton(
                style: button2(context, Theme.of(context), 24),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text('Start!', style: TextStyle(fontSize: 24.sp)),
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
                      value: true,
                      onChanged: (newValue) {},
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
                        max: 20,
                        value: 20,
                        onChanged: (newValue) {},
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      '20/20',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
