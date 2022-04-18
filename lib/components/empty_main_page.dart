import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyMainPage extends StatelessWidget {
  final String message;
  const EmptyMainPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/empty_state2.svg"),
          Text(
            "Oops! This page is empty.",
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          Opacity(
            opacity: 0.5,
            child: Text(
              message,
              style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
