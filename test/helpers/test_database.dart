import 'package:deduzai/core/database/app_database.dart';
import 'package:drift/native.dart';

AppDatabase createTestDatabase() {
  return AppDatabase.forTesting(NativeDatabase.memory());
}
