import 'dart:async';
import 'package:fitness_application/models/stop_watch.dart';
import 'package:fitness_application/util/stop_watch_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StopWatchController extends StateNotifier<StopWatch> {
  StopWatchController(this._read) : super(_initialState);
  final Reader _read;

  static const int count = 0;
  static final _initialState =
      StopWatch(count: 0, state: StopWatchState.Initial);
  static final oneSec = const Duration(seconds: 1);

  StreamSubscription<int>? _counter;
  int currentTime = 0;

  get stopWatchCount => count;

  void start() {
    _counter?.cancel();
    _counter = startCounter().listen((duration) {
      state = StopWatch(count: duration, state: StopWatchState.Running);
    });
  }

  void resume() {
    _counter = resumeCounter(currentTime).listen((duration) {
      state = StopWatch(count: currentTime, state: StopWatchState.Running);
    });
  }

  void stop() {
    _counter!.pause();
    state = StopWatch(count: currentTime, state: StopWatchState.Stopped);
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
