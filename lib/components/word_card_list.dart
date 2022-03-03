import 'package:english_dictionary/utils/objects.dart';
import 'package:flutter/material.dart';

class WordListCard extends StatelessWidget {
  final Function()? onPress;
  final WordModel wordModel;
  const WordListCard({Key? key, required this.wordModel, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16.0,
            spreadRadius: 0.0,
            offset: const Offset(0, 0),
          )
        ]),
        child: Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 12.0),
                    child: Text(
                      wordModel.type,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 28),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      wordModel.definition,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 18),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
                    child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: 'e.g. ',
                            style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 18),
                          ),
                          TextSpan(
                            text: wordModel.example,
                            style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 18),
                          ),
                        ])),
                  ),
                )
              ],
            ),
            onTap: onPress,
          ),
        ),
      ),
    );
  }
}
