import 'package:fitness_application/providers/stop_watch_provider.dart';
import 'package:fitness_application/util/colors.dart';
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
            if (timerState.state == StopWatchState.Stopped)
              CustomButton(
                key: Key("reset-button"),
                label: Text("Reset"),
                onTap: () {
                  if (timerState.state == StopWatchState.Stopped) {
                    timer.reset();
                  }
                },
              ),
            if (timerState.state != StopWatchState.Stopped)
              CustomButton(
                key: Key("lap-button"),
                label: Text("Lap"),
                color: timerState.state == StopWatchState.Initial ? Colors.grey.withOpacity(.3) : CustomColors.primaryColor ,
                onTap: () {
                  if (timerState.state == StopWatchState.Running) {
                    timer.lap();
                  }
                },
              ),
            SizedBox(
              width: 15,
            ),
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
                color: Colors.green,
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
                color: Colors.red,
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
