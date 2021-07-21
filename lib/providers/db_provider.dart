import 'package:fitness_application/repositories/db_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbProvider = ChangeNotifierProvider<DbRepository>((ref) {
  return DbRepository(ref.read);
});
