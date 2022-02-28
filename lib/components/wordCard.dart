import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WordCard extends StatelessWidget {
  final Function()? onPress;
  final String type;
  final String definition;

  final Color color1 = const Color(0xFF0F1D25);
  final Color color2 = const Color(0xFF314652);
  final Color color3 = const Color(0xFF1FF328);
  final Color color4 = const Color(0xFFEB1FF5);
  final String assetName = 'assets/images/card.svg';

  WordCard({Key? key, required this.type, required this.definition, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(24),
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
              stops: [1, 1],
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
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
