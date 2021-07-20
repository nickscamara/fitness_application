import 'package:fitness_application/providers/stop_watch_provider.dart';
import 'package:fitness_application/util/stop_watch_state.dart';
import 'package:fitness_application/widgets/custom_button.dart';
import 'package:fitness_application/widgets/stop_watch_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StopWatchWidget extends HookWidget {
  const StopWatchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timer = useProvider(stopWatchProvider.notifier);
    final timerState = useProvider(stopWatchProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StopWatchText(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // I could have used ternary with only 2 widgets, but looked too messy
            if (timerState.state == StopWatchState.Initial)
              CustomButton(
                label: Text("Start"),
                onTap: () {
                  if (timerState.state == StopWatchState.Initial) {
                    timer.start();
                  }
                },
                key: Key('start-button'),
              ),
            if (timerState.state == StopWatchState.Stopped)
              CustomButton(
                label: Text("Resume"),
                onTap: () {
                  if (timerState.state == StopWatchState.Stopped) {
                    timer.resume();
                  }
                },
                key: Key('resume-button'),
              ),
            if (timerState.state == StopWatchState.Running)
              CustomButton(
                label: Text("Stop"),
                onTap: () {
                  if (timerState.state == StopWatchState.Running) {
                    timer.stop();
                  }
                },
                key: Key('stop-button'),
              ),
          ],
        ),
      ],
    );
  }
}
