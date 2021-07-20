import 'dart:async';
import 'package:fitness_application/models/lap.dart';
import 'package:fitness_application/models/stop_watch.dart';
import 'package:fitness_application/util/stop_watch_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StopWatchController extends StateNotifier<StopWatch> {
  StopWatchController(this._read) : super(_initialState);
  final Reader _read;

  static const int count = 0;
  static final _initialState =
      StopWatch(count: 0, state: StopWatchState.Initial,laps: []);
  static final oneSec = const Duration(seconds: 1);


  StreamSubscription<int>? _counter;
  int currentTime = 0;
   List<Lap> laps = [];

  get stopWatchCount => count;

  void start() {
    _counter?.cancel();
    _counter = startCounter().listen((duration) {
      state = StopWatch(count: duration, state: StopWatchState.Running,laps:laps);
    });
  }

  void resume() {
    _counter = resumeCounter(currentTime).listen((duration) {
      state = StopWatch(count: currentTime, state: StopWatchState.Running, laps: laps);
    });
  }

  void stop() {
    _counter!.pause();
    state = StopWatch(count: currentTime, state: StopWatchState.Stopped, laps: laps);
  }

  void lap() {
    final lap = new Lap(currentTime,laps.length +1);
    laps.add(lap);
    state = StopWatch(
        count: currentTime, state: StopWatchState.Running, laps: laps);
  }

  void reset() {
    _counter?.cancel();
    laps = [];
    currentTime = 0;
    state = StopWatch(
        count: currentTime, state: StopWatchState.Initial, laps: laps);
  }

  void dispose() {
    _counter?.cancel();
  }

  Stream<int> startCounter() {
    return Stream.periodic(
      Duration(seconds: 1),
      (x) {
        currentTime = x + 1;
        return x + 1;
      },
    );
  }

  Stream<int> resumeCounter(int timeOnWatch) {
    return Stream.periodic(
      Duration(seconds: 1),
      (x) {
        currentTime = x + 1 + timeOnWatch;
        return x + 1;
      },
    );
  }
}
