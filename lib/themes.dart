import 'package:flutter/material.dart';

const lightPrimary = Color(0xFF07122A);
const darkPrimary = Color(0xFF87CEFA);
const lightBackground = Color(0xFFF5F5F5);
const textColor = Color(0xFFFFFFFF);

const lightTextColor = Colors.black;
const darkTextColor = Colors.white;

Color textColorWithOpacity(Brightness brightness, double opacity) {
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

// Color(0xAA12161B)
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ThemeData().colorScheme.copyWith(primary: darkPrimary, brightness: Brightness.dark),
  fontFamily: 'Poppins',
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
  backgroundColor: lightBackground,
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
