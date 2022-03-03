import 'package:english_dictionary/screens/add_word_manually_page.dart';
import 'package:english_dictionary/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Dictionary',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: AddWordManuallyPage(title: 'English Dictionary'),
    );
  }
}
