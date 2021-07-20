import 'package:fitness_application/util/stop_watch_state.dart';

import 'lap.dart';

class StopWatch {
  int count;
  StopWatchState state;
  List<Lap> laps;

  StopWatch({required this.count, required this.state, required this.laps});
}
