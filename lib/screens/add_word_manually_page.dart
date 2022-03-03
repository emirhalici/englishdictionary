import 'package:english_dictionary/themes.dart';
import 'package:flutter/material.dart';

class AddWordManuallyPage extends StatelessWidget {
  final TextEditingController controllerWord = TextEditingController();
  final TextEditingController controllerType = TextEditingController();
  final TextEditingController controllerDefinition = TextEditingController();
  final TextEditingController controllerExample = TextEditingController();
  final String title;
  AddWordManuallyPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Dictionary'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            Text(
              'Add Word',
              style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 36),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 26),
            TextField(
              controller: controllerWord,
              decoration: textFieldDecorationWithHint(context, 'Enter word', 'i.e apple'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controllerType,
              decoration: textFieldDecoration(context, 'Enter word type'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controllerDefinition,
              minLines: 2,
              maxLines: 3,
              textAlignVertical: TextAlignVertical.center,
              decoration: textFieldDecoration(context, 'Enter definition'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controllerExample,
              minLines: 1,
              maxLines: 3,
              decoration: textFieldDecoration(context, 'Enter an example sentence'),
            ),
            const SizedBox(height: 16),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: button2(context, Theme.of(context), 8),
                      onPressed: () {},
                      child: const Text('Add Word', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextButton(
                      style: button1(context, Theme.of(context), 8),
                      onPressed: () {},
                      child: const Text('Cancel', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
