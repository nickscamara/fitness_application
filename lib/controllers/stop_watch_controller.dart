import 'dart:async';

import 'package:fitness_application/models/lap.dart';
import 'package:fitness_application/models/stop_watch.dart';
import 'package:fitness_application/providers/db_provider.dart';
import 'package:fitness_application/util/stop_watch_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StopWatchController extends StateNotifier<StopWatch> {
  StopWatchController(this._read) : super(_initialState);
  final Reader _read;

  static const int count = 0;
  static final _initialState =
      StopWatch(count: 0, state: StopWatchState.Initial, laps: []);
  static final oneSec = const Duration(seconds: 1);

  StreamSubscription<int>? _counter;
  int currentTime = 0;
  List<Lap> laps = [];

  get stopWatchCount => count;

  /// Set Initial Values when app is reopend
  /// DB controller calls this method with the current laps and saved info on the timer
  /// Calculates the time elapses and update the state accordingly.
  void setInitialValues(List<Lap> currentLaps, StopWatchSave savedData) async {
     _counter?.cancel();
    if ((currentLaps.length != 0 || savedData.epochTime != 0) && savedData.state != StopWatchState.Initial) {
      laps=currentLaps;
      if(savedData.state == StopWatchState.Running)
      {
        final timeNow = DateTime.now().millisecondsSinceEpoch;
        final timeDifference = DateTime.fromMillisecondsSinceEpoch(timeNow).difference(DateTime.fromMillisecondsSinceEpoch(savedData.epochTime)).inSeconds;
        _counter = startCounter(initial: timeDifference + savedData.currentTime).listen((duration) {
          state = StopWatch(
              count: currentTime, state: StopWatchState.Running, laps: laps);
        });
      }else if(savedData.state == StopWatchState.Stopped)
      {
        _counter?.pause();
        currentTime = savedData.currentTime;
         state = StopWatch(
              count: currentTime, state: StopWatchState.Stopped, laps: laps);
      }
    }
  }
  /// Start the stop watch
  void start() {
    _counter?.cancel();
    _counter = startCounter().listen((duration) {
      state =
          StopWatch(count: duration, state: StopWatchState.Running, laps: laps);
    });
  }

  // Resume the stop watch based on the elapsed time
  void resume() {
    _counter = startCounter(initial:currentTime).listen((duration) {
      state = StopWatch(
          count: currentTime, state: StopWatchState.Running, laps: laps);
    });
  }

  /// Stop the stop watch
  void stop() {
    _counter!.pause();
    state = StopWatch(
        count: currentTime, state: StopWatchState.Stopped, laps: laps);
    _read(dbProvider).saveTime(currentTime, state.state);

  }

  /// Counts a lap
  void lap() async {
    final lap = new Lap(currentTime, laps.length +1);
    _read(dbProvider).saveLap(lap);
    laps.add(lap);
    state = StopWatch(
        count: currentTime, state: StopWatchState.Running, laps: laps);
  }

  /// Resets the timer
  void reset() {
    _read(dbProvider).getLaps();
    _read(dbProvider).deleteEntries();
    _counter?.cancel();
    laps = [];
    currentTime = 0;
    state = StopWatch(
        count: currentTime, state: StopWatchState.Initial, laps: laps);
  }

  /// Starts the counter stream, save time in db every seconds
  /// Alternative to this is using App Lifecycle
  /// I almost got it but ran into some issues, decided to take the simpler
  /// route for the sake of the exercise
  Stream<int> startCounter({int initial = 0}) {
    return Stream.periodic(
      Duration(seconds: 1),
      (x) {
        currentTime = x + 1 + initial;
        _read(dbProvider).saveTime(currentTime, state.state);
        return x + 1;
      },
    );
  }

}
