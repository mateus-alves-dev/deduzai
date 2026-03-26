import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Reactive list of active (non-deleted) dependents, ordered by name.
final dependentListProvider = StreamProvider<List<Dependent>>(
  (ref) => ref.watch(dependentsDaoProvider).watchAll(),
);
