import 'package:fitness_application/models/lap.dart';
import 'package:fitness_application/models/stop_watch.dart';
import 'package:fitness_application/providers/stop_watch_provider.dart';
import 'package:fitness_application/util/stop_watch_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;


class DbRepository with ChangeNotifier {


  late Reader reader;
  static final lapsTableName = 'laps';
  static final timesTableName = 'times';
  static final dbName = 'database.db';
  late sql.Database db;

  DbRepository(Reader r) {
    this.reader = r;
    // Initialize db
    init();
  }

  void init() async {
    final dbPath = await sql.getDatabasesPath();
    db = await sql.openDatabase(
      path.join(dbPath, dbName),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $timesTableName (id INTEGER PRIMARY KEY, currentTime INTEGER, epochTime INTEGER, state STRING)');
        return db.execute(
            'CREATE TABLE $lapsTableName (id INTEGER PRIMARY KEY, lapNum INTEGER, currentTime INTEGER)');
      },
      version: 3,
    );
    final laps = await getLaps();
    final savedData = await getSaved();
    reader(stopWatchProvider.notifier).setInitialValues(laps, savedData);
    notifyListeners();
  }

  Future<void> insert(String table, Map<String, Object> data) async {
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    return await db.query(table);
  }

  void deleteEntries() async {
    await db.delete(lapsTableName);
    await db.delete(timesTableName);
  }

  void saveLap(Lap lap) async {
    await insert(lapsTableName, lap.toMap());
  }

  Future<StopWatchSave> getSaved() async {
    try {
      final data = await getData(timesTableName);
      return StopWatchSave.fromMap(data.last);
    } catch (e) {
      print("EXPECTED no element (initial state) => " + e.toString());
    }
    return StopWatchSave(
        currentTime: 0, epochTime: 0, state: StopWatchState.Initial);
  }

  Future<List<Lap>> getLaps() async {
    try {
      final data = await getData(lapsTableName);
      return data.map((element) => Lap.fromMap(element)).toList();
    } catch (e) {
      print("EXPECTED no element (initial state) => " + e.toString());
    }
    return [];
  }

  void saveTime(int currentTime, StopWatchState state) async {
    await insert(
        timesTableName,
        new StopWatchSave(
                currentTime: currentTime,
                epochTime: DateTime.now().millisecondsSinceEpoch,
                state: state)
            .toMap());
  }

  
}
