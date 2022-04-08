import 'package:english_dictionary/screens/add_word_page.dart';
import 'package:english_dictionary/screens/home_page.dart';
import 'package:english_dictionary/screens/quiz_start_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/main_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String title = 'English Dictionary';

  void _onTap(int val, BuildContext context) {
    if (_currentIndex == val) {
      switch (val) {
        case 0:
          if (context.read<MainProvider>().wordList.isNotEmpty) {
            context.read<MainProvider>().scrollToTop();
          }

          _mainScreen.currentState?.popUntil((route) => route.isFirst);
          break;
        case 1:
          _quizStartScreen.currentState?.popUntil((route) => route.isFirst);
          break;
        case 2:
          _addWordScreen.currentState?.popUntil((route) => route.isFirst);
          break;
        default:
      }
    } else {
      if (mounted) {
        setState(() {
          _currentIndex = val;
        });
      }
    }
  }

  int _currentIndex = 0;

  final _mainScreen = GlobalKey<NavigatorState>();
  final _quizStartScreen = GlobalKey<NavigatorState>();
  final _addWordScreen = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Navigator(
            key: _mainScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const HomePage(),
            ),
          ),
          Navigator(
            key: _quizStartScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const QuizStartPage(),
            ),
          ),
          Navigator(
            key: _addWordScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const AddWordPage(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: _currentIndex,
        onTap: (val) => _onTap(val, context),
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
    );
  }
}
