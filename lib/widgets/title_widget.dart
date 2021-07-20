import 'package:fitness_application/util/colors.dart';
import 'package:flutter/material.dart';

import 'gradient_text.dart';

class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: GradientText(
          "Stopwatch",
          gradient: const LinearGradient(colors: [
            CustomColors.c1,
            CustomColors.c2,
            CustomColors.c3,
            CustomColors.c4,
          ]),
          style: const TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.w200),
        ),
      ),
    );
  }
}
