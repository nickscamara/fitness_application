import 'package:fitness_application/providers/stop_watch_provider.dart';
import 'package:fitness_application/util/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StopWatchText extends HookWidget {
  const StopWatchText({Key? key}) : super(key: const Key("stop-watch"));

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(stopWatchProvider);
    return Text(
      Helper.durationCalc(provider.count).toString(),
      style: TextStyle(
        fontSize: 75,
        color: Colors.white,
        fontWeight: FontWeight.w100,
      ),
    );
  }
}
