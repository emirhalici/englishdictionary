import 'package:flutter/material.dart';

const lightPrimary = Color(0xFF1C2541);
const darkPrimary = Color(0xFF87CEFA);
const lightBackground = Color(0xFFF5F5F5);
const textColor = Color(0xFFFFFFFF);
Color? textColor2 = textColor.withOpacity(0.7);
MaterialColor darkSwatch = createMaterialColor(darkPrimary);
ColorScheme darkScheme = ColorScheme.fromSwatch(primarySwatch: darkSwatch);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(secondary: darkPrimary),
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w900, color: Colors.white),
    headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white),
    headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.white),
    bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
    bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.white),
  ),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightPrimary,
  primarySwatch: createMaterialColor(lightPrimary),
  backgroundColor: lightBackground,
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w900, color: Colors.black),
    headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.black),
    headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.black),
    bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black),
    bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.black),
  ),
);

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
