// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final Function()? onPress;
  final String type;
  final String definition;

  final Color color1 = const Color(0xFF1B5D83);
  final Color color2 = const Color(0xFF000F31);
  final String assetName = 'assets/images/card.svg';

  const WordCard({Key? key, required this.type, required this.definition, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[color1, color2]),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.centerRight,
              radius: 0.7,
              colors: <Color>[Colors.white.withOpacity(0.05), Colors.black.withOpacity(0.0)],
              stops: const [0.95, 1],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        type,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 28, color: Colors.white),
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  definition,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontSize: 26, fontWeight: FontWeight.w400, height: 1.2, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
