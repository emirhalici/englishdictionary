import 'dart:ui';

import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final Function()? onPress;
  final String type;
  final String definition;

  final Color color1 = const Color(0xFF364E5B);
  final Color color2 = const Color(0xFF06173D);
  final String assetName = 'assets/images/card.svg';

  WordCard({Key? key, required this.type, required this.definition, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[color1, color1]),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.centerRight,
              radius: 0.7,
              colors: <Color>[Colors.white.withOpacity(0.05), Colors.black.withOpacity(0.0)],
              stops: [0.95, 1],
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
                        'adjective',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 28),
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Exemption from punishment or freedom from the injurious consequences of an action.',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      ),
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