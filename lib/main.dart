import 'package:englishdictionary/components/wordCard.dart';
import 'package:englishdictionary/models/apiHelper.dart';
import 'package:englishdictionary/models/quizHelper.dart';
import 'package:englishdictionary/themes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/objects.dart';

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
      home: const MyHomePage(title: 'English Dictionary'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                'Good afternoon, Emir',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                'Exchange Rates',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'headline 3',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'bodytext 1',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                'bodytext 2',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              TextButton(
                style: button1(Theme.of(context)),
                onPressed: () {},
                child: const Text('button1'),
              ),
              ElevatedButton(
                style: button2(Theme.of(context)),
                onPressed: () {},
                child: const Text('Search Word'),
              ),
              OutlinedButton(
                style: button3(Theme.of(context)),
                onPressed: () {},
                child: const Text('Add Manually'),
              ),
              WordCard(
                type: 'noun',
                definition: 'Exemption  from punishment or freedom from  the injurious consequences of  an action.',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
