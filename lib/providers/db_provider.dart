import 'package:fitness_application/controllers/db_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

final dbProvider = ChangeNotifierProvider<DbController>((ref) {
  return DbController(ref.read);
});
