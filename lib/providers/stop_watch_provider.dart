import 'package:fitness_application/controllers/stop_watch_controller.dart';
import 'package:fitness_application/models/stop_watch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stopWatchProvider = StateNotifierProvider<StopWatchController, StopWatch>(
  (ref) => StopWatchController(ref.read),
);