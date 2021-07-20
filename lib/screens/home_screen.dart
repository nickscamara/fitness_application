import 'package:fitness_application/util/colors.dart';
import 'package:fitness_application/widgets/stop_watch_widget.dart';
import 'package:fitness_application/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: const LinearGradient(
                colors: [CustomColors.bgdColor, CustomColors.bgdColor2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        width: screenSize.width,
        height: screenSize.height,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              TitleWidget(),
              StopWatchWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
