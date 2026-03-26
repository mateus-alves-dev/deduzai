import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/daos/dependents_dao.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/relationship.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'dependent_service.g.dart';

@riverpod
DependentService dependentService(Ref ref) =>
    DependentService(ref.watch(dependentsDaoProvider));

class DependentService {
  DependentService(this._dao);

  final DependentsDao _dao;
  static const _uuid = Uuid();

  Future<String> create({
    required String name,
    required Relationship relationship,
    required DateTime birthDate,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();
    await _dao.insertDependent(
      DependentsCompanion.insert(
        id: id,
        name: name,
        relationship: relationship.value,
        birthDate: birthDate,
        createdAt: now,
      ),
    );
    return id;
  }

  Future<void> update({
    required Dependent existing,
    String? name,
    Relationship? relationship,
    DateTime? birthDate,
  }) async {
    await _dao.updateDependent(
      DependentsCompanion(
        id: Value(existing.id),
        name: Value(name ?? existing.name),
        relationship:
            Value(relationship?.value ?? existing.relationship),
        birthDate: Value(birthDate ?? existing.birthDate),
        createdAt: Value(existing.createdAt),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> softDelete(String id) => _dao.softDelete(id);
}
