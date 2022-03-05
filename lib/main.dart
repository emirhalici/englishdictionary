import 'package:english_dictionary/screens/add_word_manually_page.dart';
import 'package:english_dictionary/screens/add_word_page.dart';
import 'package:english_dictionary/screens/main_page.dart';
import 'package:english_dictionary/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title = 'English Dictionary';

  List<Widget> pages = [
    const MainPage(),
    AddWordManuallyPage(),
    const AddWordPage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        title: title,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Quiz',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add',
              ),
            ],
          ),
          appBar: AppBar(
            title: Text(title),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: pages[_selectedIndex],
        ),
      ),
      designSize: const Size(375, 812),
    );
  }
}
