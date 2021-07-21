import 'package:fitness_application/util/stop_watch_state.dart';

class Helper {
  static String durationCalc(int duration) {
    final minutes = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final seconds = (duration % 60).floor().toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
  static StopWatchState processState(String s) {
  print(s);
  if (s == "StopWatchState.Initial") {
    return StopWatchState.Initial;
  } else if (s == "StopWatchState.Running") {
    return StopWatchState.Running;
  } else {
    return StopWatchState.Stopped;
  }
}
}
