import 'package:fitness_application/util/helper.dart';
import 'package:fitness_application/util/stop_watch_state.dart';

import 'lap.dart';

class StopWatch {
  int count;
  StopWatchState state;
  List<Lap> laps;

  StopWatch({required this.count, required this.state, required this.laps});
}

class StopWatchSave {
  int currentTime;
  int epochTime;
  StopWatchState state;

  StopWatchSave(
      {required this.currentTime,
      required this.epochTime,
      required this.state});

  toMap() {
    return {
      "currentTime": currentTime,
      "epochTime": epochTime,
      "state": state.toString(),
    };
  }

  StopWatchSave.fromMap(Map<String, dynamic> map)
      : currentTime = map['currentTime'],
        epochTime = map['epochTime'],
        state = Helper.processState(map['state']);
}
