import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const lightPrimary = Color(0xFF07122A);
const darkPrimary = Color(0xFF87CEFA);
const lightBackground = Color(0xFFF5F5F5);
const textColor = Color(0xFFFFFFFF);

const lightTextColor = Colors.black;
const darkTextColor = Colors.white;

Color textColorWithOpacity(BuildContext context, double opacity) {
  Brightness brightness = Theme.of(context).brightness;
  Color textColor = themeTextColor(brightness);
  return textColor.withOpacity(opacity);
}

Color themeTextColor(Brightness brightness) {
  return brightness == Brightness.dark ? lightTextColor : darkTextColor;
}

ButtonStyle button1(BuildContext context, ThemeData theme, double radius) {
  return TextButton.styleFrom(
    primary: theme.textTheme.bodyText1?.color,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
  );
}

ButtonStyle button2(BuildContext context, ThemeData theme, double radius) {
  return ElevatedButton.styleFrom(
      primary: theme.brightness == Brightness.dark ? darkPrimary : lightPrimary,
      onPrimary: themeTextColor(theme.brightness),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)));
}

ButtonStyle button3(BuildContext context, ThemeData theme, double radius) {
  return OutlinedButton.styleFrom(
      primary: theme.brightness == Brightness.dark ? darkTextColor : lightTextColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)));
}

ButtonStyle questionButtonStyle(BuildContext context) {
  ThemeData theme = Theme.of(context);
  return ElevatedButton.styleFrom(
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    primary: theme.brightness == Brightness.dark ? Colors.white.withAlpha(80) : const Color(0xAAF0F0F0),
    onSurface: Colors.black,
    onPrimary: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
    maximumSize: Size(double.infinity, MediaQuery.of(context).size.height * 0.1),
  );
}

ButtonStyle correctButtonStyle(BuildContext context) {
  return ElevatedButton.styleFrom(
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    primary: Colors.greenAccent,
    onSurface: Colors.green.shade800,
    onPrimary: Colors.black,
    maximumSize: Size(double.infinity, MediaQuery.of(context).size.height * 0.1),
  );
}

ButtonStyle wrongButtonStyle(BuildContext context) {
  return ElevatedButton.styleFrom(
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    primary: Colors.redAccent,
    onSurface: Colors.red.shade800,
    onPrimary: Colors.black,
    maximumSize: Size(double.infinity, MediaQuery.of(context).size.height * 0.1),
  );
}

ButtonStyle quizButtonStyleWithColor(BuildContext context, Color color) {
  return ElevatedButton.styleFrom(
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    primary: color,
    onPrimary: Colors.black,
  );
}

TextStyle quizButtonStyle(ThemeData theme) {
  return TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    //color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
  );
}

// Color(0xAA12161B)
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ThemeData().colorScheme.copyWith(primary: darkPrimary, brightness: Brightness.dark),
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: const Color(0xAA1F2225),
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w900, color: Colors.white),
    headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white),
    headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.white),
    bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
    bodyText2: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600, color: Colors.white),
  ),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ThemeData().colorScheme.copyWith(primary: lightPrimary, brightness: Brightness.light),
  scaffoldBackgroundColor: lightBackground,
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700, color: Colors.black),
    headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.black),
    headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.black),
    headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.black),
    bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black),
    bodyText2: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600, color: Colors.white),
  ),
);

ThemeData theme = ThemeData(
  colorScheme: const ColorScheme(
    primary: Color(0xAA07122A),
    primaryContainer: Color(0xAA112b64),
    secondary: Color(0xAA758ECD),
    secondaryContainer: Color(0xAA506fbf),
    surface: Color(0xAAFFFFFF),
    background: Color(0xAAe6e6e6),
    error: Color(0xAAe1001e),
    onPrimary: Color(0xAAFFFFFF),
    onSecondary: Color(0xAAFFFFFF),
    onSurface: Color(0xAA000000),
    onBackground: Color(0xAA000000),
    onError: Color(0xAAFFFFFF),
    brightness: Brightness.light,
  ),
  fontFamily: 'Poppins',
);

Color chipBorderColor(BuildContext context) {
  Brightness brightness = Theme.of(context).brightness;

  if (brightness == Brightness.light) {
    return Theme.of(context).colorScheme.primary;
  } else {
    return Colors.white;
  }
}

InputDecoration textFieldDecoration(BuildContext context, String label) {
  Color borderColor = themeTextColor((Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark)).withAlpha(100);

  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: borderColor),
    ),
    labelText: label,
    contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
    alignLabelWithHint: true,
  );
}

InputDecoration textFieldDecorationWithHint(BuildContext context, String label, String hint) {
  Color borderColor = themeTextColor((Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark)).withAlpha(100);
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: borderColor),
    ),
    labelText: label,
    contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
    alignLabelWithHint: true,
  );
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
