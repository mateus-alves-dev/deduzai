// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountInCentsMeta = const VerificationMeta(
    'amountInCents',
  );
  @override
  late final GeneratedColumn<int> amountInCents = GeneratedColumn<int>(
    'amount_in_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiptPathMeta = const VerificationMeta(
    'receiptPath',
  );
  @override
  late final GeneratedColumn<String> receiptPath = GeneratedColumn<String>(
    'receipt_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _beneficiarioMeta = const VerificationMeta(
    'beneficiario',
  );
  @override
  late final GeneratedColumn<String> beneficiario = GeneratedColumn<String>(
    'beneficiario',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cnpjMeta = const VerificationMeta('cnpj');
  @override
  late final GeneratedColumn<String> cnpj = GeneratedColumn<String>(
    'cnpj',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _origemMeta = const VerificationMeta('origem');
  @override
  late final GeneratedColumn<String> origem = GeneratedColumn<String>(
    'origem',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('MANUAL'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    category,
    amountInCents,
    description,
    receiptPath,
    beneficiario,
    cnpj,
    origem,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount_in_cents')) {
      context.handle(
        _amountInCentsMeta,
        amountInCents.isAcceptableOrUnknown(
          data['amount_in_cents']!,
          _amountInCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountInCentsMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('receipt_path')) {
      context.handle(
        _receiptPathMeta,
        receiptPath.isAcceptableOrUnknown(
          data['receipt_path']!,
          _receiptPathMeta,
        ),
      );
    }
    if (data.containsKey('beneficiario')) {
      context.handle(
        _beneficiarioMeta,
        beneficiario.isAcceptableOrUnknown(
          data['beneficiario']!,
          _beneficiarioMeta,
        ),
      );
    }
    if (data.containsKey('cnpj')) {
      context.handle(
        _cnpjMeta,
        cnpj.isAcceptableOrUnknown(data['cnpj']!, _cnpjMeta),
      );
    }
    if (data.containsKey('origem')) {
      context.handle(
        _origemMeta,
        origem.isAcceptableOrUnknown(data['origem']!, _origemMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      amountInCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_in_cents'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      receiptPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_path'],
      ),
      beneficiario: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}beneficiario'],
      ),
      cnpj: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cnpj'],
      ),
      origem: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origem'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final String id;
  final DateTime date;
  final String category;
  final int amountInCents;
  final String description;
  final String? receiptPath;
  final String? beneficiario;
  final String? cnpj;
  final String origem;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const Expense({
    required this.id,
    required this.date,
    required this.category,
    required this.amountInCents,
    required this.description,
    this.receiptPath,
    this.beneficiario,
    this.cnpj,
    required this.origem,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['category'] = Variable<String>(category);
    map['amount_in_cents'] = Variable<int>(amountInCents);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || receiptPath != null) {
      map['receipt_path'] = Variable<String>(receiptPath);
    }
    if (!nullToAbsent || beneficiario != null) {
      map['beneficiario'] = Variable<String>(beneficiario);
    }
    if (!nullToAbsent || cnpj != null) {
      map['cnpj'] = Variable<String>(cnpj);
    }
    map['origem'] = Variable<String>(origem);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      date: Value(date),
      category: Value(category),
      amountInCents: Value(amountInCents),
      description: Value(description),
      receiptPath: receiptPath == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptPath),
      beneficiario: beneficiario == null && nullToAbsent
          ? const Value.absent()
          : Value(beneficiario),
      cnpj: cnpj == null && nullToAbsent ? const Value.absent() : Value(cnpj),
      origem: Value(origem),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      category: serializer.fromJson<String>(json['category']),
      amountInCents: serializer.fromJson<int>(json['amountInCents']),
      description: serializer.fromJson<String>(json['description']),
      receiptPath: serializer.fromJson<String?>(json['receiptPath']),
      beneficiario: serializer.fromJson<String?>(json['beneficiario']),
      cnpj: serializer.fromJson<String?>(json['cnpj']),
      origem: serializer.fromJson<String>(json['origem']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'category': serializer.toJson<String>(category),
      'amountInCents': serializer.toJson<int>(amountInCents),
      'description': serializer.toJson<String>(description),
      'receiptPath': serializer.toJson<String?>(receiptPath),
      'beneficiario': serializer.toJson<String?>(beneficiario),
      'cnpj': serializer.toJson<String?>(cnpj),
      'origem': serializer.toJson<String>(origem),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Expense copyWith({
    String? id,
    DateTime? date,
    String? category,
    int? amountInCents,
    String? description,
    Value<String?> receiptPath = const Value.absent(),
    Value<String?> beneficiario = const Value.absent(),
    Value<String?> cnpj = const Value.absent(),
    String? origem,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Expense(
    id: id ?? this.id,
    date: date ?? this.date,
    category: category ?? this.category,
    amountInCents: amountInCents ?? this.amountInCents,
    description: description ?? this.description,
    receiptPath: receiptPath.present ? receiptPath.value : this.receiptPath,
    beneficiario: beneficiario.present ? beneficiario.value : this.beneficiario,
    cnpj: cnpj.present ? cnpj.value : this.cnpj,
    origem: origem ?? this.origem,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      category: data.category.present ? data.category.value : this.category,
      amountInCents: data.amountInCents.present
          ? data.amountInCents.value
          : this.amountInCents,
      description: data.description.present
          ? data.description.value
          : this.description,
      receiptPath: data.receiptPath.present
          ? data.receiptPath.value
          : this.receiptPath,
      beneficiario: data.beneficiario.present
          ? data.beneficiario.value
          : this.beneficiario,
      cnpj: data.cnpj.present ? data.cnpj.value : this.cnpj,
      origem: data.origem.present ? data.origem.value : this.origem,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('amountInCents: $amountInCents, ')
          ..write('description: $description, ')
          ..write('receiptPath: $receiptPath, ')
          ..write('beneficiario: $beneficiario, ')
          ..write('cnpj: $cnpj, ')
          ..write('origem: $origem, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    category,
    amountInCents,
    description,
    receiptPath,
    beneficiario,
    cnpj,
    origem,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.date == this.date &&
          other.category == this.category &&
          other.amountInCents == this.amountInCents &&
          other.description == this.description &&
          other.receiptPath == this.receiptPath &&
          other.beneficiario == this.beneficiario &&
          other.cnpj == this.cnpj &&
          other.origem == this.origem &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String> category;
  final Value<int> amountInCents;
  final Value<String> description;
  final Value<String?> receiptPath;
  final Value<String?> beneficiario;
  final Value<String?> cnpj;
  final Value<String> origem;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.category = const Value.absent(),
    this.amountInCents = const Value.absent(),
    this.description = const Value.absent(),
    this.receiptPath = const Value.absent(),
    this.beneficiario = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.origem = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    required String id,
    required DateTime date,
    required String category,
    required int amountInCents,
    required String description,
    this.receiptPath = const Value.absent(),
    this.beneficiario = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.origem = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       category = Value(category),
       amountInCents = Value(amountInCents),
       description = Value(description),
       createdAt = Value(createdAt);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? category,
    Expression<int>? amountInCents,
    Expression<String>? description,
    Expression<String>? receiptPath,
    Expression<String>? beneficiario,
    Expression<String>? cnpj,
    Expression<String>? origem,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (category != null) 'category': category,
      if (amountInCents != null) 'amount_in_cents': amountInCents,
      if (description != null) 'description': description,
      if (receiptPath != null) 'receipt_path': receiptPath,
      if (beneficiario != null) 'beneficiario': beneficiario,
      if (cnpj != null) 'cnpj': cnpj,
      if (origem != null) 'origem': origem,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<String>? category,
    Value<int>? amountInCents,
    Value<String>? description,
    Value<String?>? receiptPath,
    Value<String?>? beneficiario,
    Value<String?>? cnpj,
    Value<String>? origem,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      category: category ?? this.category,
      amountInCents: amountInCents ?? this.amountInCents,
      description: description ?? this.description,
      receiptPath: receiptPath ?? this.receiptPath,
      beneficiario: beneficiario ?? this.beneficiario,
      cnpj: cnpj ?? this.cnpj,
      origem: origem ?? this.origem,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amountInCents.present) {
      map['amount_in_cents'] = Variable<int>(amountInCents.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (receiptPath.present) {
      map['receipt_path'] = Variable<String>(receiptPath.value);
    }
    if (beneficiario.present) {
      map['beneficiario'] = Variable<String>(beneficiario.value);
    }
    if (cnpj.present) {
      map['cnpj'] = Variable<String>(cnpj.value);
    }
    if (origem.present) {
      map['origem'] = Variable<String>(origem.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('amountInCents: $amountInCents, ')
          ..write('description: $description, ')
          ..write('receiptPath: $receiptPath, ')
          ..write('beneficiario: $beneficiario, ')
          ..write('cnpj: $cnpj, ')
          ..write('origem: $origem, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReceiptsTable extends Receipts with TableInfo<$ReceiptsTable, Receipt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expenseIdMeta = const VerificationMeta(
    'expenseId',
  );
  @override
  late final GeneratedColumn<String> expenseId = GeneratedColumn<String>(
    'expense_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES expenses (id)',
    ),
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tamanhoBytesMeta = const VerificationMeta(
    'tamanhoBytes',
  );
  @override
  late final GeneratedColumn<int> tamanhoBytes = GeneratedColumn<int>(
    'tamanho_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ocrStatusMeta = const VerificationMeta(
    'ocrStatus',
  );
  @override
  late final GeneratedColumn<String> ocrStatus = GeneratedColumn<String>(
    'ocr_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    expenseId,
    localPath,
    mimeType,
    tamanhoBytes,
    ocrStatus,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Receipt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('expense_id')) {
      context.handle(
        _expenseIdMeta,
        expenseId.isAcceptableOrUnknown(data['expense_id']!, _expenseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_expenseIdMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('tamanho_bytes')) {
      context.handle(
        _tamanhoBytesMeta,
        tamanhoBytes.isAcceptableOrUnknown(
          data['tamanho_bytes']!,
          _tamanhoBytesMeta,
        ),
      );
    }
    if (data.containsKey('ocr_status')) {
      context.handle(
        _ocrStatusMeta,
        ocrStatus.isAcceptableOrUnknown(data['ocr_status']!, _ocrStatusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Receipt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Receipt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      expenseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expense_id'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      ),
      tamanhoBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tamanho_bytes'],
      ),
      ocrStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ocr_status'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ReceiptsTable createAlias(String alias) {
    return $ReceiptsTable(attachedDatabase, alias);
  }
}

class Receipt extends DataClass implements Insertable<Receipt> {
  final String id;
  final String expenseId;
  final String localPath;
  final String? mimeType;
  final int? tamanhoBytes;
  final String? ocrStatus;
  final DateTime createdAt;
  const Receipt({
    required this.id,
    required this.expenseId,
    required this.localPath,
    this.mimeType,
    this.tamanhoBytes,
    this.ocrStatus,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['expense_id'] = Variable<String>(expenseId);
    map['local_path'] = Variable<String>(localPath);
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    if (!nullToAbsent || tamanhoBytes != null) {
      map['tamanho_bytes'] = Variable<int>(tamanhoBytes);
    }
    if (!nullToAbsent || ocrStatus != null) {
      map['ocr_status'] = Variable<String>(ocrStatus);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: Value(id),
      expenseId: Value(expenseId),
      localPath: Value(localPath),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      tamanhoBytes: tamanhoBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(tamanhoBytes),
      ocrStatus: ocrStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(ocrStatus),
      createdAt: Value(createdAt),
    );
  }

  factory Receipt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Receipt(
      id: serializer.fromJson<String>(json['id']),
      expenseId: serializer.fromJson<String>(json['expenseId']),
      localPath: serializer.fromJson<String>(json['localPath']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      tamanhoBytes: serializer.fromJson<int?>(json['tamanhoBytes']),
      ocrStatus: serializer.fromJson<String?>(json['ocrStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'expenseId': serializer.toJson<String>(expenseId),
      'localPath': serializer.toJson<String>(localPath),
      'mimeType': serializer.toJson<String?>(mimeType),
      'tamanhoBytes': serializer.toJson<int?>(tamanhoBytes),
      'ocrStatus': serializer.toJson<String?>(ocrStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Receipt copyWith({
    String? id,
    String? expenseId,
    String? localPath,
    Value<String?> mimeType = const Value.absent(),
    Value<int?> tamanhoBytes = const Value.absent(),
    Value<String?> ocrStatus = const Value.absent(),
    DateTime? createdAt,
  }) => Receipt(
    id: id ?? this.id,
    expenseId: expenseId ?? this.expenseId,
    localPath: localPath ?? this.localPath,
    mimeType: mimeType.present ? mimeType.value : this.mimeType,
    tamanhoBytes: tamanhoBytes.present ? tamanhoBytes.value : this.tamanhoBytes,
    ocrStatus: ocrStatus.present ? ocrStatus.value : this.ocrStatus,
    createdAt: createdAt ?? this.createdAt,
  );
  Receipt copyWithCompanion(ReceiptsCompanion data) {
    return Receipt(
      id: data.id.present ? data.id.value : this.id,
      expenseId: data.expenseId.present ? data.expenseId.value : this.expenseId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      tamanhoBytes: data.tamanhoBytes.present
          ? data.tamanhoBytes.value
          : this.tamanhoBytes,
      ocrStatus: data.ocrStatus.present ? data.ocrStatus.value : this.ocrStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Receipt(')
          ..write('id: $id, ')
          ..write('expenseId: $expenseId, ')
          ..write('localPath: $localPath, ')
          ..write('mimeType: $mimeType, ')
          ..write('tamanhoBytes: $tamanhoBytes, ')
          ..write('ocrStatus: $ocrStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    expenseId,
    localPath,
    mimeType,
    tamanhoBytes,
    ocrStatus,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Receipt &&
          other.id == this.id &&
          other.expenseId == this.expenseId &&
          other.localPath == this.localPath &&
          other.mimeType == this.mimeType &&
          other.tamanhoBytes == this.tamanhoBytes &&
          other.ocrStatus == this.ocrStatus &&
          other.createdAt == this.createdAt);
}

class ReceiptsCompanion extends UpdateCompanion<Receipt> {
  final Value<String> id;
  final Value<String> expenseId;
  final Value<String> localPath;
  final Value<String?> mimeType;
  final Value<int?> tamanhoBytes;
  final Value<String?> ocrStatus;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.expenseId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.tamanhoBytes = const Value.absent(),
    this.ocrStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    required String id,
    required String expenseId,
    required String localPath,
    this.mimeType = const Value.absent(),
    this.tamanhoBytes = const Value.absent(),
    this.ocrStatus = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       expenseId = Value(expenseId),
       localPath = Value(localPath),
       createdAt = Value(createdAt);
  static Insertable<Receipt> custom({
    Expression<String>? id,
    Expression<String>? expenseId,
    Expression<String>? localPath,
    Expression<String>? mimeType,
    Expression<int>? tamanhoBytes,
    Expression<String>? ocrStatus,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (expenseId != null) 'expense_id': expenseId,
      if (localPath != null) 'local_path': localPath,
      if (mimeType != null) 'mime_type': mimeType,
      if (tamanhoBytes != null) 'tamanho_bytes': tamanhoBytes,
      if (ocrStatus != null) 'ocr_status': ocrStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReceiptsCompanion copyWith({
    Value<String>? id,
    Value<String>? expenseId,
    Value<String>? localPath,
    Value<String?>? mimeType,
    Value<int?>? tamanhoBytes,
    Value<String?>? ocrStatus,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      expenseId: expenseId ?? this.expenseId,
      localPath: localPath ?? this.localPath,
      mimeType: mimeType ?? this.mimeType,
      tamanhoBytes: tamanhoBytes ?? this.tamanhoBytes,
      ocrStatus: ocrStatus ?? this.ocrStatus,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (expenseId.present) {
      map['expense_id'] = Variable<String>(expenseId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (tamanhoBytes.present) {
      map['tamanho_bytes'] = Variable<int>(tamanhoBytes.value);
    }
    if (ocrStatus.present) {
      map['ocr_status'] = Variable<String>(ocrStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('expenseId: $expenseId, ')
          ..write('localPath: $localPath, ')
          ..write('mimeType: $mimeType, ')
          ..write('tamanhoBytes: $tamanhoBytes, ')
          ..write('ocrStatus: $ocrStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CnpjPreferencesTable extends CnpjPreferences
    with TableInfo<$CnpjPreferencesTable, CnpjPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CnpjPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cnpjMeta = const VerificationMeta('cnpj');
  @override
  late final GeneratedColumn<String> cnpj = GeneratedColumn<String>(
    'cnpj',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _beneficiarioMeta = const VerificationMeta(
    'beneficiario',
  );
  @override
  late final GeneratedColumn<String> beneficiario = GeneratedColumn<String>(
    'beneficiario',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cnaeDescricaoMeta = const VerificationMeta(
    'cnaeDescricao',
  );
  @override
  late final GeneratedColumn<String> cnaeDescricao = GeneratedColumn<String>(
    'cnae_descricao',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    cnpj,
    category,
    beneficiario,
    cnaeDescricao,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cnpj_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<CnpjPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cnpj')) {
      context.handle(
        _cnpjMeta,
        cnpj.isAcceptableOrUnknown(data['cnpj']!, _cnpjMeta),
      );
    } else if (isInserting) {
      context.missing(_cnpjMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('beneficiario')) {
      context.handle(
        _beneficiarioMeta,
        beneficiario.isAcceptableOrUnknown(
          data['beneficiario']!,
          _beneficiarioMeta,
        ),
      );
    }
    if (data.containsKey('cnae_descricao')) {
      context.handle(
        _cnaeDescricaoMeta,
        cnaeDescricao.isAcceptableOrUnknown(
          data['cnae_descricao']!,
          _cnaeDescricaoMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cnpj};
  @override
  CnpjPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CnpjPreference(
      cnpj: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cnpj'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      beneficiario: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}beneficiario'],
      ),
      cnaeDescricao: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cnae_descricao'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CnpjPreferencesTable createAlias(String alias) {
    return $CnpjPreferencesTable(attachedDatabase, alias);
  }
}

class CnpjPreference extends DataClass implements Insertable<CnpjPreference> {
  final String cnpj;
  final String category;
  final String? beneficiario;
  final String? cnaeDescricao;
  final DateTime updatedAt;
  const CnpjPreference({
    required this.cnpj,
    required this.category,
    this.beneficiario,
    this.cnaeDescricao,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['cnpj'] = Variable<String>(cnpj);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || beneficiario != null) {
      map['beneficiario'] = Variable<String>(beneficiario);
    }
    if (!nullToAbsent || cnaeDescricao != null) {
      map['cnae_descricao'] = Variable<String>(cnaeDescricao);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CnpjPreferencesCompanion toCompanion(bool nullToAbsent) {
    return CnpjPreferencesCompanion(
      cnpj: Value(cnpj),
      category: Value(category),
      beneficiario: beneficiario == null && nullToAbsent
          ? const Value.absent()
          : Value(beneficiario),
      cnaeDescricao: cnaeDescricao == null && nullToAbsent
          ? const Value.absent()
          : Value(cnaeDescricao),
      updatedAt: Value(updatedAt),
    );
  }

  factory CnpjPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CnpjPreference(
      cnpj: serializer.fromJson<String>(json['cnpj']),
      category: serializer.fromJson<String>(json['category']),
      beneficiario: serializer.fromJson<String?>(json['beneficiario']),
      cnaeDescricao: serializer.fromJson<String?>(json['cnaeDescricao']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cnpj': serializer.toJson<String>(cnpj),
      'category': serializer.toJson<String>(category),
      'beneficiario': serializer.toJson<String?>(beneficiario),
      'cnaeDescricao': serializer.toJson<String?>(cnaeDescricao),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CnpjPreference copyWith({
    String? cnpj,
    String? category,
    Value<String?> beneficiario = const Value.absent(),
    Value<String?> cnaeDescricao = const Value.absent(),
    DateTime? updatedAt,
  }) => CnpjPreference(
    cnpj: cnpj ?? this.cnpj,
    category: category ?? this.category,
    beneficiario: beneficiario.present ? beneficiario.value : this.beneficiario,
    cnaeDescricao: cnaeDescricao.present
        ? cnaeDescricao.value
        : this.cnaeDescricao,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CnpjPreference copyWithCompanion(CnpjPreferencesCompanion data) {
    return CnpjPreference(
      cnpj: data.cnpj.present ? data.cnpj.value : this.cnpj,
      category: data.category.present ? data.category.value : this.category,
      beneficiario: data.beneficiario.present
          ? data.beneficiario.value
          : this.beneficiario,
      cnaeDescricao: data.cnaeDescricao.present
          ? data.cnaeDescricao.value
          : this.cnaeDescricao,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CnpjPreference(')
          ..write('cnpj: $cnpj, ')
          ..write('category: $category, ')
          ..write('beneficiario: $beneficiario, ')
          ..write('cnaeDescricao: $cnaeDescricao, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(cnpj, category, beneficiario, cnaeDescricao, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CnpjPreference &&
          other.cnpj == this.cnpj &&
          other.category == this.category &&
          other.beneficiario == this.beneficiario &&
          other.cnaeDescricao == this.cnaeDescricao &&
          other.updatedAt == this.updatedAt);
}

class CnpjPreferencesCompanion extends UpdateCompanion<CnpjPreference> {
  final Value<String> cnpj;
  final Value<String> category;
  final Value<String?> beneficiario;
  final Value<String?> cnaeDescricao;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CnpjPreferencesCompanion({
    this.cnpj = const Value.absent(),
    this.category = const Value.absent(),
    this.beneficiario = const Value.absent(),
    this.cnaeDescricao = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CnpjPreferencesCompanion.insert({
    required String cnpj,
    required String category,
    this.beneficiario = const Value.absent(),
    this.cnaeDescricao = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : cnpj = Value(cnpj),
       category = Value(category),
       updatedAt = Value(updatedAt);
  static Insertable<CnpjPreference> custom({
    Expression<String>? cnpj,
    Expression<String>? category,
    Expression<String>? beneficiario,
    Expression<String>? cnaeDescricao,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cnpj != null) 'cnpj': cnpj,
      if (category != null) 'category': category,
      if (beneficiario != null) 'beneficiario': beneficiario,
      if (cnaeDescricao != null) 'cnae_descricao': cnaeDescricao,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CnpjPreferencesCompanion copyWith({
    Value<String>? cnpj,
    Value<String>? category,
    Value<String?>? beneficiario,
    Value<String?>? cnaeDescricao,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CnpjPreferencesCompanion(
      cnpj: cnpj ?? this.cnpj,
      category: category ?? this.category,
      beneficiario: beneficiario ?? this.beneficiario,
      cnaeDescricao: cnaeDescricao ?? this.cnaeDescricao,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cnpj.present) {
      map['cnpj'] = Variable<String>(cnpj.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (beneficiario.present) {
      map['beneficiario'] = Variable<String>(beneficiario.value);
    }
    if (cnaeDescricao.present) {
      map['cnae_descricao'] = Variable<String>(cnaeDescricao.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CnpjPreferencesCompanion(')
          ..write('cnpj: $cnpj, ')
          ..write('category: $category, ')
          ..write('beneficiario: $beneficiario, ')
          ..write('cnaeDescricao: $cnaeDescricao, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  const AppSetting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(key: Value(key), value: Value(value));
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSetting copyWith({String? key, String? value}) =>
      AppSetting(key: key ?? this.key, value: value ?? this.value);
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecurringExpensesTable extends RecurringExpenses
    with TableInfo<$RecurringExpensesTable, RecurringExpense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountInCentsMeta = const VerificationMeta(
    'amountInCents',
  );
  @override
  late final GeneratedColumn<int> amountInCents = GeneratedColumn<int>(
    'amount_in_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayOfMonthMeta = const VerificationMeta(
    'dayOfMonth',
  );
  @override
  late final GeneratedColumn<int> dayOfMonth = GeneratedColumn<int>(
    'day_of_month',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceDateMeta = const VerificationMeta(
    'referenceDate',
  );
  @override
  late final GeneratedColumn<DateTime> referenceDate =
      GeneratedColumn<DateTime>(
        'reference_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _nextDueDateMeta = const VerificationMeta(
    'nextDueDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextDueDate = GeneratedColumn<DateTime>(
    'next_due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _beneficiarioMeta = const VerificationMeta(
    'beneficiario',
  );
  @override
  late final GeneratedColumn<String> beneficiario = GeneratedColumn<String>(
    'beneficiario',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cnpjMeta = const VerificationMeta('cnpj');
  @override
  late final GeneratedColumn<String> cnpj = GeneratedColumn<String>(
    'cnpj',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    description,
    amountInCents,
    category,
    frequency,
    dayOfMonth,
    referenceDate,
    nextDueDate,
    beneficiario,
    cnpj,
    isActive,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurringExpense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount_in_cents')) {
      context.handle(
        _amountInCentsMeta,
        amountInCents.isAcceptableOrUnknown(
          data['amount_in_cents']!,
          _amountInCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountInCentsMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('day_of_month')) {
      context.handle(
        _dayOfMonthMeta,
        dayOfMonth.isAcceptableOrUnknown(
          data['day_of_month']!,
          _dayOfMonthMeta,
        ),
      );
    }
    if (data.containsKey('reference_date')) {
      context.handle(
        _referenceDateMeta,
        referenceDate.isAcceptableOrUnknown(
          data['reference_date']!,
          _referenceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_referenceDateMeta);
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
        _nextDueDateMeta,
        nextDueDate.isAcceptableOrUnknown(
          data['next_due_date']!,
          _nextDueDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextDueDateMeta);
    }
    if (data.containsKey('beneficiario')) {
      context.handle(
        _beneficiarioMeta,
        beneficiario.isAcceptableOrUnknown(
          data['beneficiario']!,
          _beneficiarioMeta,
        ),
      );
    }
    if (data.containsKey('cnpj')) {
      context.handle(
        _cnpjMeta,
        cnpj.isAcceptableOrUnknown(data['cnpj']!, _cnpjMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringExpense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringExpense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      amountInCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_in_cents'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      dayOfMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_of_month'],
      ),
      referenceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reference_date'],
      )!,
      nextDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_due_date'],
      )!,
      beneficiario: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}beneficiario'],
      ),
      cnpj: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cnpj'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $RecurringExpensesTable createAlias(String alias) {
    return $RecurringExpensesTable(attachedDatabase, alias);
  }
}

class RecurringExpense extends DataClass
    implements Insertable<RecurringExpense> {
  final String id;
  final String description;
  final int amountInCents;
  final String category;
  final String frequency;
  final int? dayOfMonth;
  final DateTime referenceDate;
  final DateTime nextDueDate;
  final String? beneficiario;
  final String? cnpj;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const RecurringExpense({
    required this.id,
    required this.description,
    required this.amountInCents,
    required this.category,
    required this.frequency,
    this.dayOfMonth,
    required this.referenceDate,
    required this.nextDueDate,
    this.beneficiario,
    this.cnpj,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['description'] = Variable<String>(description);
    map['amount_in_cents'] = Variable<int>(amountInCents);
    map['category'] = Variable<String>(category);
    map['frequency'] = Variable<String>(frequency);
    if (!nullToAbsent || dayOfMonth != null) {
      map['day_of_month'] = Variable<int>(dayOfMonth);
    }
    map['reference_date'] = Variable<DateTime>(referenceDate);
    map['next_due_date'] = Variable<DateTime>(nextDueDate);
    if (!nullToAbsent || beneficiario != null) {
      map['beneficiario'] = Variable<String>(beneficiario);
    }
    if (!nullToAbsent || cnpj != null) {
      map['cnpj'] = Variable<String>(cnpj);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  RecurringExpensesCompanion toCompanion(bool nullToAbsent) {
    return RecurringExpensesCompanion(
      id: Value(id),
      description: Value(description),
      amountInCents: Value(amountInCents),
      category: Value(category),
      frequency: Value(frequency),
      dayOfMonth: dayOfMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(dayOfMonth),
      referenceDate: Value(referenceDate),
      nextDueDate: Value(nextDueDate),
      beneficiario: beneficiario == null && nullToAbsent
          ? const Value.absent()
          : Value(beneficiario),
      cnpj: cnpj == null && nullToAbsent ? const Value.absent() : Value(cnpj),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory RecurringExpense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringExpense(
      id: serializer.fromJson<String>(json['id']),
      description: serializer.fromJson<String>(json['description']),
      amountInCents: serializer.fromJson<int>(json['amountInCents']),
      category: serializer.fromJson<String>(json['category']),
      frequency: serializer.fromJson<String>(json['frequency']),
      dayOfMonth: serializer.fromJson<int?>(json['dayOfMonth']),
      referenceDate: serializer.fromJson<DateTime>(json['referenceDate']),
      nextDueDate: serializer.fromJson<DateTime>(json['nextDueDate']),
      beneficiario: serializer.fromJson<String?>(json['beneficiario']),
      cnpj: serializer.fromJson<String?>(json['cnpj']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'description': serializer.toJson<String>(description),
      'amountInCents': serializer.toJson<int>(amountInCents),
      'category': serializer.toJson<String>(category),
      'frequency': serializer.toJson<String>(frequency),
      'dayOfMonth': serializer.toJson<int?>(dayOfMonth),
      'referenceDate': serializer.toJson<DateTime>(referenceDate),
      'nextDueDate': serializer.toJson<DateTime>(nextDueDate),
      'beneficiario': serializer.toJson<String?>(beneficiario),
      'cnpj': serializer.toJson<String?>(cnpj),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  RecurringExpense copyWith({
    String? id,
    String? description,
    int? amountInCents,
    String? category,
    String? frequency,
    Value<int?> dayOfMonth = const Value.absent(),
    DateTime? referenceDate,
    DateTime? nextDueDate,
    Value<String?> beneficiario = const Value.absent(),
    Value<String?> cnpj = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => RecurringExpense(
    id: id ?? this.id,
    description: description ?? this.description,
    amountInCents: amountInCents ?? this.amountInCents,
    category: category ?? this.category,
    frequency: frequency ?? this.frequency,
    dayOfMonth: dayOfMonth.present ? dayOfMonth.value : this.dayOfMonth,
    referenceDate: referenceDate ?? this.referenceDate,
    nextDueDate: nextDueDate ?? this.nextDueDate,
    beneficiario: beneficiario.present ? beneficiario.value : this.beneficiario,
    cnpj: cnpj.present ? cnpj.value : this.cnpj,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  RecurringExpense copyWithCompanion(RecurringExpensesCompanion data) {
    return RecurringExpense(
      id: data.id.present ? data.id.value : this.id,
      description: data.description.present
          ? data.description.value
          : this.description,
      amountInCents: data.amountInCents.present
          ? data.amountInCents.value
          : this.amountInCents,
      category: data.category.present ? data.category.value : this.category,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      dayOfMonth: data.dayOfMonth.present
          ? data.dayOfMonth.value
          : this.dayOfMonth,
      referenceDate: data.referenceDate.present
          ? data.referenceDate.value
          : this.referenceDate,
      nextDueDate: data.nextDueDate.present
          ? data.nextDueDate.value
          : this.nextDueDate,
      beneficiario: data.beneficiario.present
          ? data.beneficiario.value
          : this.beneficiario,
      cnpj: data.cnpj.present ? data.cnpj.value : this.cnpj,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringExpense(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('amountInCents: $amountInCents, ')
          ..write('category: $category, ')
          ..write('frequency: $frequency, ')
          ..write('dayOfMonth: $dayOfMonth, ')
          ..write('referenceDate: $referenceDate, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('beneficiario: $beneficiario, ')
          ..write('cnpj: $cnpj, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    description,
    amountInCents,
    category,
    frequency,
    dayOfMonth,
    referenceDate,
    nextDueDate,
    beneficiario,
    cnpj,
    isActive,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringExpense &&
          other.id == this.id &&
          other.description == this.description &&
          other.amountInCents == this.amountInCents &&
          other.category == this.category &&
          other.frequency == this.frequency &&
          other.dayOfMonth == this.dayOfMonth &&
          other.referenceDate == this.referenceDate &&
          other.nextDueDate == this.nextDueDate &&
          other.beneficiario == this.beneficiario &&
          other.cnpj == this.cnpj &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class RecurringExpensesCompanion extends UpdateCompanion<RecurringExpense> {
  final Value<String> id;
  final Value<String> description;
  final Value<int> amountInCents;
  final Value<String> category;
  final Value<String> frequency;
  final Value<int?> dayOfMonth;
  final Value<DateTime> referenceDate;
  final Value<DateTime> nextDueDate;
  final Value<String?> beneficiario;
  final Value<String?> cnpj;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const RecurringExpensesCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.amountInCents = const Value.absent(),
    this.category = const Value.absent(),
    this.frequency = const Value.absent(),
    this.dayOfMonth = const Value.absent(),
    this.referenceDate = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.beneficiario = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecurringExpensesCompanion.insert({
    required String id,
    required String description,
    required int amountInCents,
    required String category,
    required String frequency,
    this.dayOfMonth = const Value.absent(),
    required DateTime referenceDate,
    required DateTime nextDueDate,
    this.beneficiario = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       description = Value(description),
       amountInCents = Value(amountInCents),
       category = Value(category),
       frequency = Value(frequency),
       referenceDate = Value(referenceDate),
       nextDueDate = Value(nextDueDate),
       createdAt = Value(createdAt);
  static Insertable<RecurringExpense> custom({
    Expression<String>? id,
    Expression<String>? description,
    Expression<int>? amountInCents,
    Expression<String>? category,
    Expression<String>? frequency,
    Expression<int>? dayOfMonth,
    Expression<DateTime>? referenceDate,
    Expression<DateTime>? nextDueDate,
    Expression<String>? beneficiario,
    Expression<String>? cnpj,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (amountInCents != null) 'amount_in_cents': amountInCents,
      if (category != null) 'category': category,
      if (frequency != null) 'frequency': frequency,
      if (dayOfMonth != null) 'day_of_month': dayOfMonth,
      if (referenceDate != null) 'reference_date': referenceDate,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
      if (beneficiario != null) 'beneficiario': beneficiario,
      if (cnpj != null) 'cnpj': cnpj,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecurringExpensesCompanion copyWith({
    Value<String>? id,
    Value<String>? description,
    Value<int>? amountInCents,
    Value<String>? category,
    Value<String>? frequency,
    Value<int?>? dayOfMonth,
    Value<DateTime>? referenceDate,
    Value<DateTime>? nextDueDate,
    Value<String?>? beneficiario,
    Value<String?>? cnpj,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return RecurringExpensesCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      amountInCents: amountInCents ?? this.amountInCents,
      category: category ?? this.category,
      frequency: frequency ?? this.frequency,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
      referenceDate: referenceDate ?? this.referenceDate,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      beneficiario: beneficiario ?? this.beneficiario,
      cnpj: cnpj ?? this.cnpj,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amountInCents.present) {
      map['amount_in_cents'] = Variable<int>(amountInCents.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (dayOfMonth.present) {
      map['day_of_month'] = Variable<int>(dayOfMonth.value);
    }
    if (referenceDate.present) {
      map['reference_date'] = Variable<DateTime>(referenceDate.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate.value);
    }
    if (beneficiario.present) {
      map['beneficiario'] = Variable<String>(beneficiario.value);
    }
    if (cnpj.present) {
      map['cnpj'] = Variable<String>(cnpj.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringExpensesCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('amountInCents: $amountInCents, ')
          ..write('category: $category, ')
          ..write('frequency: $frequency, ')
          ..write('dayOfMonth: $dayOfMonth, ')
          ..write('referenceDate: $referenceDate, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('beneficiario: $beneficiario, ')
          ..write('cnpj: $cnpj, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FilterFavoritesTable extends FilterFavorites
    with TableInfo<$FilterFavoritesTable, FilterFavorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FilterFavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoriasMeta = const VerificationMeta(
    'categorias',
  );
  @override
  late final GeneratedColumn<String> categorias = GeneratedColumn<String>(
    'categorias',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dataInicioMeta = const VerificationMeta(
    'dataInicio',
  );
  @override
  late final GeneratedColumn<DateTime> dataInicio = GeneratedColumn<DateTime>(
    'data_inicio',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dataFimMeta = const VerificationMeta(
    'dataFim',
  );
  @override
  late final GeneratedColumn<DateTime> dataFim = GeneratedColumn<DateTime>(
    'data_fim',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _valorMinMeta = const VerificationMeta(
    'valorMin',
  );
  @override
  late final GeneratedColumn<int> valorMin = GeneratedColumn<int>(
    'valor_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _valorMaxMeta = const VerificationMeta(
    'valorMax',
  );
  @override
  late final GeneratedColumn<int> valorMax = GeneratedColumn<int>(
    'valor_max',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _comComprovanteMeta = const VerificationMeta(
    'comComprovante',
  );
  @override
  late final GeneratedColumn<bool> comComprovante = GeneratedColumn<bool>(
    'com_comprovante',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("com_comprovante" IN (0, 1))',
    ),
  );
  static const VerificationMeta _criadoEmMeta = const VerificationMeta(
    'criadoEm',
  );
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
    'criado_em',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _atualizadoEmMeta = const VerificationMeta(
    'atualizadoEm',
  );
  @override
  late final GeneratedColumn<DateTime> atualizadoEm = GeneratedColumn<DateTime>(
    'atualizado_em',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nome,
    categorias,
    dataInicio,
    dataFim,
    valorMin,
    valorMax,
    comComprovante,
    criadoEm,
    atualizadoEm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'filter_favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<FilterFavorite> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('categorias')) {
      context.handle(
        _categoriasMeta,
        categorias.isAcceptableOrUnknown(data['categorias']!, _categoriasMeta),
      );
    }
    if (data.containsKey('data_inicio')) {
      context.handle(
        _dataInicioMeta,
        dataInicio.isAcceptableOrUnknown(data['data_inicio']!, _dataInicioMeta),
      );
    }
    if (data.containsKey('data_fim')) {
      context.handle(
        _dataFimMeta,
        dataFim.isAcceptableOrUnknown(data['data_fim']!, _dataFimMeta),
      );
    }
    if (data.containsKey('valor_min')) {
      context.handle(
        _valorMinMeta,
        valorMin.isAcceptableOrUnknown(data['valor_min']!, _valorMinMeta),
      );
    }
    if (data.containsKey('valor_max')) {
      context.handle(
        _valorMaxMeta,
        valorMax.isAcceptableOrUnknown(data['valor_max']!, _valorMaxMeta),
      );
    }
    if (data.containsKey('com_comprovante')) {
      context.handle(
        _comComprovanteMeta,
        comComprovante.isAcceptableOrUnknown(
          data['com_comprovante']!,
          _comComprovanteMeta,
        ),
      );
    }
    if (data.containsKey('criado_em')) {
      context.handle(
        _criadoEmMeta,
        criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta),
      );
    } else if (isInserting) {
      context.missing(_criadoEmMeta);
    }
    if (data.containsKey('atualizado_em')) {
      context.handle(
        _atualizadoEmMeta,
        atualizadoEm.isAcceptableOrUnknown(
          data['atualizado_em']!,
          _atualizadoEmMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_atualizadoEmMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FilterFavorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FilterFavorite(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      categorias: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categorias'],
      ),
      dataInicio: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data_inicio'],
      ),
      dataFim: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data_fim'],
      ),
      valorMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}valor_min'],
      ),
      valorMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}valor_max'],
      ),
      comComprovante: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}com_comprovante'],
      ),
      criadoEm: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}criado_em'],
      )!,
      atualizadoEm: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}atualizado_em'],
      )!,
    );
  }

  @override
  $FilterFavoritesTable createAlias(String alias) {
    return $FilterFavoritesTable(attachedDatabase, alias);
  }
}

class FilterFavorite extends DataClass implements Insertable<FilterFavorite> {
  final String id;
  final String nome;
  final String? categorias;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final int? valorMin;
  final int? valorMax;
  final bool? comComprovante;
  final DateTime criadoEm;
  final DateTime atualizadoEm;
  const FilterFavorite({
    required this.id,
    required this.nome,
    this.categorias,
    this.dataInicio,
    this.dataFim,
    this.valorMin,
    this.valorMax,
    this.comComprovante,
    required this.criadoEm,
    required this.atualizadoEm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nome'] = Variable<String>(nome);
    if (!nullToAbsent || categorias != null) {
      map['categorias'] = Variable<String>(categorias);
    }
    if (!nullToAbsent || dataInicio != null) {
      map['data_inicio'] = Variable<DateTime>(dataInicio);
    }
    if (!nullToAbsent || dataFim != null) {
      map['data_fim'] = Variable<DateTime>(dataFim);
    }
    if (!nullToAbsent || valorMin != null) {
      map['valor_min'] = Variable<int>(valorMin);
    }
    if (!nullToAbsent || valorMax != null) {
      map['valor_max'] = Variable<int>(valorMax);
    }
    if (!nullToAbsent || comComprovante != null) {
      map['com_comprovante'] = Variable<bool>(comComprovante);
    }
    map['criado_em'] = Variable<DateTime>(criadoEm);
    map['atualizado_em'] = Variable<DateTime>(atualizadoEm);
    return map;
  }

  FilterFavoritesCompanion toCompanion(bool nullToAbsent) {
    return FilterFavoritesCompanion(
      id: Value(id),
      nome: Value(nome),
      categorias: categorias == null && nullToAbsent
          ? const Value.absent()
          : Value(categorias),
      dataInicio: dataInicio == null && nullToAbsent
          ? const Value.absent()
          : Value(dataInicio),
      dataFim: dataFim == null && nullToAbsent
          ? const Value.absent()
          : Value(dataFim),
      valorMin: valorMin == null && nullToAbsent
          ? const Value.absent()
          : Value(valorMin),
      valorMax: valorMax == null && nullToAbsent
          ? const Value.absent()
          : Value(valorMax),
      comComprovante: comComprovante == null && nullToAbsent
          ? const Value.absent()
          : Value(comComprovante),
      criadoEm: Value(criadoEm),
      atualizadoEm: Value(atualizadoEm),
    );
  }

  factory FilterFavorite.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FilterFavorite(
      id: serializer.fromJson<String>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      categorias: serializer.fromJson<String?>(json['categorias']),
      dataInicio: serializer.fromJson<DateTime?>(json['dataInicio']),
      dataFim: serializer.fromJson<DateTime?>(json['dataFim']),
      valorMin: serializer.fromJson<int?>(json['valorMin']),
      valorMax: serializer.fromJson<int?>(json['valorMax']),
      comComprovante: serializer.fromJson<bool?>(json['comComprovante']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
      atualizadoEm: serializer.fromJson<DateTime>(json['atualizadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nome': serializer.toJson<String>(nome),
      'categorias': serializer.toJson<String?>(categorias),
      'dataInicio': serializer.toJson<DateTime?>(dataInicio),
      'dataFim': serializer.toJson<DateTime?>(dataFim),
      'valorMin': serializer.toJson<int?>(valorMin),
      'valorMax': serializer.toJson<int?>(valorMax),
      'comComprovante': serializer.toJson<bool?>(comComprovante),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
      'atualizadoEm': serializer.toJson<DateTime>(atualizadoEm),
    };
  }

  FilterFavorite copyWith({
    String? id,
    String? nome,
    Value<String?> categorias = const Value.absent(),
    Value<DateTime?> dataInicio = const Value.absent(),
    Value<DateTime?> dataFim = const Value.absent(),
    Value<int?> valorMin = const Value.absent(),
    Value<int?> valorMax = const Value.absent(),
    Value<bool?> comComprovante = const Value.absent(),
    DateTime? criadoEm,
    DateTime? atualizadoEm,
  }) => FilterFavorite(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    categorias: categorias.present ? categorias.value : this.categorias,
    dataInicio: dataInicio.present ? dataInicio.value : this.dataInicio,
    dataFim: dataFim.present ? dataFim.value : this.dataFim,
    valorMin: valorMin.present ? valorMin.value : this.valorMin,
    valorMax: valorMax.present ? valorMax.value : this.valorMax,
    comComprovante: comComprovante.present
        ? comComprovante.value
        : this.comComprovante,
    criadoEm: criadoEm ?? this.criadoEm,
    atualizadoEm: atualizadoEm ?? this.atualizadoEm,
  );
  FilterFavorite copyWithCompanion(FilterFavoritesCompanion data) {
    return FilterFavorite(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      categorias: data.categorias.present
          ? data.categorias.value
          : this.categorias,
      dataInicio: data.dataInicio.present
          ? data.dataInicio.value
          : this.dataInicio,
      dataFim: data.dataFim.present ? data.dataFim.value : this.dataFim,
      valorMin: data.valorMin.present ? data.valorMin.value : this.valorMin,
      valorMax: data.valorMax.present ? data.valorMax.value : this.valorMax,
      comComprovante: data.comComprovante.present
          ? data.comComprovante.value
          : this.comComprovante,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
      atualizadoEm: data.atualizadoEm.present
          ? data.atualizadoEm.value
          : this.atualizadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FilterFavorite(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('categorias: $categorias, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataFim: $dataFim, ')
          ..write('valorMin: $valorMin, ')
          ..write('valorMax: $valorMax, ')
          ..write('comComprovante: $comComprovante, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nome,
    categorias,
    dataInicio,
    dataFim,
    valorMin,
    valorMax,
    comComprovante,
    criadoEm,
    atualizadoEm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FilterFavorite &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.categorias == this.categorias &&
          other.dataInicio == this.dataInicio &&
          other.dataFim == this.dataFim &&
          other.valorMin == this.valorMin &&
          other.valorMax == this.valorMax &&
          other.comComprovante == this.comComprovante &&
          other.criadoEm == this.criadoEm &&
          other.atualizadoEm == this.atualizadoEm);
}

class FilterFavoritesCompanion extends UpdateCompanion<FilterFavorite> {
  final Value<String> id;
  final Value<String> nome;
  final Value<String?> categorias;
  final Value<DateTime?> dataInicio;
  final Value<DateTime?> dataFim;
  final Value<int?> valorMin;
  final Value<int?> valorMax;
  final Value<bool?> comComprovante;
  final Value<DateTime> criadoEm;
  final Value<DateTime> atualizadoEm;
  final Value<int> rowid;
  const FilterFavoritesCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.categorias = const Value.absent(),
    this.dataInicio = const Value.absent(),
    this.dataFim = const Value.absent(),
    this.valorMin = const Value.absent(),
    this.valorMax = const Value.absent(),
    this.comComprovante = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FilterFavoritesCompanion.insert({
    required String id,
    required String nome,
    this.categorias = const Value.absent(),
    this.dataInicio = const Value.absent(),
    this.dataFim = const Value.absent(),
    this.valorMin = const Value.absent(),
    this.valorMax = const Value.absent(),
    this.comComprovante = const Value.absent(),
    required DateTime criadoEm,
    required DateTime atualizadoEm,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nome = Value(nome),
       criadoEm = Value(criadoEm),
       atualizadoEm = Value(atualizadoEm);
  static Insertable<FilterFavorite> custom({
    Expression<String>? id,
    Expression<String>? nome,
    Expression<String>? categorias,
    Expression<DateTime>? dataInicio,
    Expression<DateTime>? dataFim,
    Expression<int>? valorMin,
    Expression<int>? valorMax,
    Expression<bool>? comComprovante,
    Expression<DateTime>? criadoEm,
    Expression<DateTime>? atualizadoEm,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (categorias != null) 'categorias': categorias,
      if (dataInicio != null) 'data_inicio': dataInicio,
      if (dataFim != null) 'data_fim': dataFim,
      if (valorMin != null) 'valor_min': valorMin,
      if (valorMax != null) 'valor_max': valorMax,
      if (comComprovante != null) 'com_comprovante': comComprovante,
      if (criadoEm != null) 'criado_em': criadoEm,
      if (atualizadoEm != null) 'atualizado_em': atualizadoEm,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FilterFavoritesCompanion copyWith({
    Value<String>? id,
    Value<String>? nome,
    Value<String?>? categorias,
    Value<DateTime?>? dataInicio,
    Value<DateTime?>? dataFim,
    Value<int?>? valorMin,
    Value<int?>? valorMax,
    Value<bool?>? comComprovante,
    Value<DateTime>? criadoEm,
    Value<DateTime>? atualizadoEm,
    Value<int>? rowid,
  }) {
    return FilterFavoritesCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      categorias: categorias ?? this.categorias,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFim: dataFim ?? this.dataFim,
      valorMin: valorMin ?? this.valorMin,
      valorMax: valorMax ?? this.valorMax,
      comComprovante: comComprovante ?? this.comComprovante,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (categorias.present) {
      map['categorias'] = Variable<String>(categorias.value);
    }
    if (dataInicio.present) {
      map['data_inicio'] = Variable<DateTime>(dataInicio.value);
    }
    if (dataFim.present) {
      map['data_fim'] = Variable<DateTime>(dataFim.value);
    }
    if (valorMin.present) {
      map['valor_min'] = Variable<int>(valorMin.value);
    }
    if (valorMax.present) {
      map['valor_max'] = Variable<int>(valorMax.value);
    }
    if (comComprovante.present) {
      map['com_comprovante'] = Variable<bool>(comComprovante.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    if (atualizadoEm.present) {
      map['atualizado_em'] = Variable<DateTime>(atualizadoEm.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilterFavoritesCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('categorias: $categorias, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataFim: $dataFim, ')
          ..write('valorMin: $valorMin, ')
          ..write('valorMax: $valorMax, ')
          ..write('comComprovante: $comComprovante, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DependentsTable extends Dependents
    with TableInfo<$DependentsTable, Dependent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DependentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relationshipMeta = const VerificationMeta(
    'relationship',
  );
  @override
  late final GeneratedColumn<String> relationship = GeneratedColumn<String>(
    'relationship',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    relationship,
    birthDate,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dependents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Dependent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('relationship')) {
      context.handle(
        _relationshipMeta,
        relationship.isAcceptableOrUnknown(
          data['relationship']!,
          _relationshipMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relationshipMeta);
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    } else if (isInserting) {
      context.missing(_birthDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Dependent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Dependent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      relationship: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relationship'],
      )!,
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $DependentsTable createAlias(String alias) {
    return $DependentsTable(attachedDatabase, alias);
  }
}

class Dependent extends DataClass implements Insertable<Dependent> {
  final String id;
  final String name;
  final String relationship;
  final DateTime birthDate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const Dependent({
    required this.id,
    required this.name,
    required this.relationship,
    required this.birthDate,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['relationship'] = Variable<String>(relationship);
    map['birth_date'] = Variable<DateTime>(birthDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  DependentsCompanion toCompanion(bool nullToAbsent) {
    return DependentsCompanion(
      id: Value(id),
      name: Value(name),
      relationship: Value(relationship),
      birthDate: Value(birthDate),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Dependent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Dependent(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      relationship: serializer.fromJson<String>(json['relationship']),
      birthDate: serializer.fromJson<DateTime>(json['birthDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'relationship': serializer.toJson<String>(relationship),
      'birthDate': serializer.toJson<DateTime>(birthDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Dependent copyWith({
    String? id,
    String? name,
    String? relationship,
    DateTime? birthDate,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Dependent(
    id: id ?? this.id,
    name: name ?? this.name,
    relationship: relationship ?? this.relationship,
    birthDate: birthDate ?? this.birthDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Dependent copyWithCompanion(DependentsCompanion data) {
    return Dependent(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      relationship: data.relationship.present
          ? data.relationship.value
          : this.relationship,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Dependent(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('relationship: $relationship, ')
          ..write('birthDate: $birthDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    relationship,
    birthDate,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dependent &&
          other.id == this.id &&
          other.name == this.name &&
          other.relationship == this.relationship &&
          other.birthDate == this.birthDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class DependentsCompanion extends UpdateCompanion<Dependent> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> relationship;
  final Value<DateTime> birthDate;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const DependentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.relationship = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DependentsCompanion.insert({
    required String id,
    required String name,
    required String relationship,
    required DateTime birthDate,
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       relationship = Value(relationship),
       birthDate = Value(birthDate),
       createdAt = Value(createdAt);
  static Insertable<Dependent> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? relationship,
    Expression<DateTime>? birthDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (relationship != null) 'relationship': relationship,
      if (birthDate != null) 'birth_date': birthDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DependentsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? relationship,
    Value<DateTime>? birthDate,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return DependentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      relationship: relationship ?? this.relationship,
      birthDate: birthDate ?? this.birthDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (relationship.present) {
      map['relationship'] = Variable<String>(relationship.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DependentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('relationship: $relationship, ')
          ..write('birthDate: $birthDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $ReceiptsTable receipts = $ReceiptsTable(this);
  late final $CnpjPreferencesTable cnpjPreferences = $CnpjPreferencesTable(
    this,
  );
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $RecurringExpensesTable recurringExpenses =
      $RecurringExpensesTable(this);
  late final $FilterFavoritesTable filterFavorites = $FilterFavoritesTable(
    this,
  );
  late final $DependentsTable dependents = $DependentsTable(this);
  late final ExpenseDao expenseDao = ExpenseDao(this as AppDatabase);
  late final ReceiptDao receiptDao = ReceiptDao(this as AppDatabase);
  late final CnpjPreferenceDao cnpjPreferenceDao = CnpjPreferenceDao(
    this as AppDatabase,
  );
  late final AppSettingsDao appSettingsDao = AppSettingsDao(
    this as AppDatabase,
  );
  late final RecurringExpenseDao recurringExpenseDao = RecurringExpenseDao(
    this as AppDatabase,
  );
  late final FilterFavoriteDao filterFavoriteDao = FilterFavoriteDao(
    this as AppDatabase,
  );
  late final DependentsDao dependentsDao = DependentsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    expenses,
    receipts,
    cnpjPreferences,
    appSettings,
    recurringExpenses,
    filterFavorites,
    dependents,
  ];
}

typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      required String id,
      required DateTime date,
      required String category,
      required int amountInCents,
      required String description,
      Value<String?> receiptPath,
      Value<String?> beneficiario,
      Value<String?> cnpj,
      Value<String> origem,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<String> category,
      Value<int> amountInCents,
      Value<String> description,
      Value<String?> receiptPath,
      Value<String?> beneficiario,
      Value<String?> cnpj,
      Value<String> origem,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$ExpensesTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTable, Expense> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ReceiptsTable, List<Receipt>> _receiptsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.receipts,
    aliasName: $_aliasNameGenerator(db.expenses.id, db.receipts.expenseId),
  );

  $$ReceiptsTableProcessedTableManager get receiptsRefs {
    final manager = $$ReceiptsTableTableManager(
      $_db,
      $_db.receipts,
    ).filter((f) => f.expenseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_receiptsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountInCents => $composableBuilder(
    column: $table.amountInCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get beneficiario => $composableBuilder(
    column: $table.beneficiario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cnpj => $composableBuilder(
    column: $table.cnpj,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origem => $composableBuilder(
    column: $table.origem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> receiptsRefs(
    Expression<bool> Function($$ReceiptsTableFilterComposer f) f,
  ) {
    final $$ReceiptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.expenseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableFilterComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountInCents => $composableBuilder(
    column: $table.amountInCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get beneficiario => $composableBuilder(
    column: $table.beneficiario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cnpj => $composableBuilder(
    column: $table.cnpj,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origem => $composableBuilder(
    column: $table.origem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get amountInCents => $composableBuilder(
    column: $table.amountInCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get beneficiario => $composableBuilder(
    column: $table.beneficiario,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cnpj =>
      $composableBuilder(column: $table.cnpj, builder: (column) => column);

  GeneratedColumn<String> get origem =>
      $composableBuilder(column: $table.origem, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> receiptsRefs<T extends Object>(
    Expression<T> Function($$ReceiptsTableAnnotationComposer a) f,
  ) {
    final $$ReceiptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.expenseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableAnnotationComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, $$ExpensesTableReferences),
          Expense,
          PrefetchHooks Function({bool receiptsRefs})
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> amountInCents = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> receiptPath = const Value.absent(),
                Value<String?> beneficiario = const Value.absent(),
                Value<String?> cnpj = const Value.absent(),
                Value<String> origem = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                date: date,
                category: category,
                amountInCents: amountInCents,
                description: description,
                receiptPath: receiptPath,
                beneficiario: beneficiario,
                cnpj: cnpj,
                origem: origem,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required String category,
                required int amountInCents,
                required String description,
                Value<String?> receiptPath = const Value.absent(),
                Value<String?> beneficiario = const Value.absent(),
                Value<String?> cnpj = const Value.absent(),
                Value<String> origem = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                date: date,
                category: category,
                amountInCents: amountInCents,
                description: description,
                receiptPath: receiptPath,
                beneficiario: beneficiario,
                cnpj: cnpj,
                origem: origem,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({receiptsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (receiptsRefs) db.receipts],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (receiptsRefs)
                    await $_getPrefetchedData<Expense, $ExpensesTable, Receipt>(
                      currentTable: table,
                      referencedTable: $$ExpensesTableReferences
                          ._receiptsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ExpensesTableReferences(db, table, p0).receiptsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.expenseId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, $$ExpensesTableReferences),
      Expense,
      PrefetchHooks Function({bool receiptsRefs})
    >;
typedef $$ReceiptsTableCreateCompanionBuilder =
    ReceiptsCompanion Function({
      required String id,
      required String expenseId,
      required String localPath,
      Value<String?> mimeType,
      Value<int?> tamanhoBytes,
      Value<String?> ocrStatus,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ReceiptsTableUpdateCompanionBuilder =
    ReceiptsCompanion Function({
      Value<String> id,
      Value<String> expenseId,
      Value<String> localPath,
      Value<String?> mimeType,
      Value<int?> tamanhoBytes,
      Value<String?> ocrStatus,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ReceiptsTableReferences
    extends BaseReferences<_$AppDatabase, $ReceiptsTable, Receipt> {
  $$ReceiptsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExpensesTable _expenseIdTable(_$AppDatabase db) => db.expenses
      .createAlias($_aliasNameGenerator(db.receipts.expenseId, db.expenses.id));

  $$ExpensesTableProcessedTableManager get expenseId {
    final $_column = $_itemColumn<String>('expense_id')!;

    final manager = $$ExpensesTableTableManager(
      $_db,
      $_db.expenses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_expenseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReceiptsTableFilterComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tamanhoBytes => $composableBuilder(
    column: $table.tamanhoBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ocrStatus => $composableBuilder(
    column: $table.ocrStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ExpensesTableFilterComposer get expenseId {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.expenseId,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableFilterComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tamanhoBytes => $composableBuilder(
    column: $table.tamanhoBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ocrStatus => $composableBuilder(
    column: $table.ocrStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExpensesTableOrderingComposer get expenseId {
    final $$ExpensesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.expenseId,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableOrderingComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get tamanhoBytes => $composableBuilder(
    column: $table.tamanhoBytes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ocrStatus =>
      $composableBuilder(column: $table.ocrStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ExpensesTableAnnotationComposer get expenseId {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.expenseId,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReceiptsTable,
          Receipt,
          $$ReceiptsTableFilterComposer,
          $$ReceiptsTableOrderingComposer,
          $$ReceiptsTableAnnotationComposer,
          $$ReceiptsTableCreateCompanionBuilder,
          $$ReceiptsTableUpdateCompanionBuilder,
          (Receipt, $$ReceiptsTableReferences),
          Receipt,
          PrefetchHooks Function({bool expenseId})
        > {
  $$ReceiptsTableTableManager(_$AppDatabase db, $ReceiptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReceiptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReceiptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReceiptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> expenseId = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<String?> mimeType = const Value.absent(),
                Value<int?> tamanhoBytes = const Value.absent(),
                Value<String?> ocrStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReceiptsCompanion(
                id: id,
                expenseId: expenseId,
                localPath: localPath,
                mimeType: mimeType,
                tamanhoBytes: tamanhoBytes,
                ocrStatus: ocrStatus,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String expenseId,
                required String localPath,
                Value<String?> mimeType = const Value.absent(),
                Value<int?> tamanhoBytes = const Value.absent(),
                Value<String?> ocrStatus = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ReceiptsCompanion.insert(
                id: id,
                expenseId: expenseId,
                localPath: localPath,
                mimeType: mimeType,
                tamanhoBytes: tamanhoBytes,
                ocrStatus: ocrStatus,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReceiptsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({expenseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (expenseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.expenseId,
                                referencedTable: $$ReceiptsTableReferences
                                    ._expenseIdTable(db),
                                referencedColumn: $$ReceiptsTableReferences
                                    ._expenseIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReceiptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReceiptsTable,
      Receipt,
      $$ReceiptsTableFilterComposer,
      $$ReceiptsTableOrderingComposer,
      $$ReceiptsTableAnnotationComposer,
      $$ReceiptsTableCreateCompanionBuilder,
      $$ReceiptsTableUpdateCompanionBuilder,
      (Receipt, $$ReceiptsTableReferences),
      Receipt,
      PrefetchHooks Function({bool expenseId})
    >;
typedef $$CnpjPreferencesTableCreateCompanionBuilder =
    CnpjPreferencesCompanion Function({
      required String cnpj,
      required String category,
      Value<String?> beneficiario,
      Value<String?> cnaeDescricao,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CnpjPreferencesTableUpdateCompanionBuilder =
    CnpjPreferencesCompanion Function({
      Value<String> cnpj,
      Value<String> category,
      Value<String?> beneficiario,
      Value<String?> cnaeDescricao,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CnpjPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $CnpjPreferencesTable> {
  $$CnpjPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cnpj => $composableBuilder(
    column: $table.cnpj,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get beneficiario => $composableBuilder(
    column: $table.beneficiario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cnaeDescricao => $composableBuilder(
    column: $table.cnaeDescricao,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CnpjPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $CnpjPreferencesTable> {
  $$CnpjPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cnpj => $composableBuilder(
    column: $table.cnpj,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get beneficiario => $composableBuilder(
    column: $table.beneficiario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cnaeDescricao => $composableBuilder(
    column: $table.cnaeDescricao,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CnpjPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CnpjPreferencesTable> {
  $$CnpjPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cnpj =>
      $composableBuilder(column: $table.cnpj, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get beneficiario => $composableBuilder(
    column: $table.beneficiario,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cnaeDescricao => $composableBuilder(
    column: $table.cnaeDescricao,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CnpjPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CnpjPreferencesTable,
          CnpjPreference,
          $$CnpjPreferencesTableFilterComposer,
          $$CnpjPreferencesTableOrderingComposer,
          $$CnpjPreferencesTableAnnotationComposer,
          $$CnpjPreferencesTableCreateCompanionBuilder,
          $$CnpjPreferencesTableUpdateCompanionBuilder,
          (
            CnpjPreference,
            BaseReferences<
              _$AppDatabase,
              $CnpjPreferencesTable,
              CnpjPreference
            >,
          ),
          CnpjPreference,
          PrefetchHooks Function()
        > {
  $$CnpjPreferencesTableTableManager(
    _$AppDatabase db,
    $CnpjPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CnpjPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CnpjPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CnpjPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> cnpj = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> beneficiario = const Value.absent(),
                Value<String?> cnaeDescricao = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CnpjPreferencesCompanion(
                cnpj: cnpj,
                category: category,
                beneficiario: beneficiario,
                cnaeDescricao: cnaeDescricao,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String cnpj,
                required String category,
                Value<String?> beneficiario = const Value.absent(),
                Value<String?> cnaeDescricao = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CnpjPreferencesCompanion.insert(
                cnpj: cnpj,
                category: category,
                beneficiario: beneficiario,
                cnaeDescricao: cnaeDescricao,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CnpjPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CnpjPreferencesTable,
      CnpjPreference,
      $$CnpjPreferencesTableFilterComposer,
      $$CnpjPreferencesTableOrderingComposer,
      $$CnpjPreferencesTableAnnotationComposer,
      $$CnpjPreferencesTableCreateCompanionBuilder,
      $$CnpjPreferencesTableUpdateCompanionBuilder,
      (
        CnpjPreference,
        BaseReferences<_$AppDatabase, $CnpjPreferencesTable, CnpjPreference>,
      ),
      CnpjPreference,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$RecurringExpensesTableCreateCompanionBuilder =
    RecurringExpensesCompanion Function({
      required String id,
      required String description,
      required int amountInCents,
      required String category,
      required String frequency,
      Value<int?> dayOfMonth,
      required DateTime referenceDate,
      required DateTime nextDueDate,
      Value<String?> beneficiario,
      Value<String?> cnpj,
      Value<bool> isActive,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$RecurringExpensesTableUpdateCompanionBuilder =
    RecurringExpensesCompanion Function({
      Value<String> id,
      Value<String> description,
      Value<int> amountInCents,
      Value<String> category,
      Value<String> frequency,
      Value<int?> dayOfMonth,
      Value<DateTime> referenceDate,
      Value<DateTime> nextDueDate,
      Value<String?> beneficiario,
      Value<String?> cnpj,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$RecurringExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringExpensesTable> {
  $$RecurringExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountInCents => $composableBuilder(
    column: $table.amountInCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get referenceDate => $composableBuilder(
    column: $table.referenceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get beneficiario => $composableBuilder(
    column: $table.beneficiario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cnpj => $composableBuilder(
    column: $table.cnpj,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecurringExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringExpensesTable> {
  $$RecurringExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountInCents => $composableBuilder(
    column: $table.amountInCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get referenceDate => $composableBuilder(
    column: $table.referenceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get beneficiario => $composableBuilder(
    column: $table.beneficiario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cnpj => $composableBuilder(
    column: $table.cnpj,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecurringExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringExpensesTable> {
  $$RecurringExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountInCents => $composableBuilder(
    column: $table.amountInCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get referenceDate => $composableBuilder(
    column: $table.referenceDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get beneficiario => $composableBuilder(
    column: $table.beneficiario,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cnpj =>
      $composableBuilder(column: $table.cnpj, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$RecurringExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecurringExpensesTable,
          RecurringExpense,
          $$RecurringExpensesTableFilterComposer,
          $$RecurringExpensesTableOrderingComposer,
          $$RecurringExpensesTableAnnotationComposer,
          $$RecurringExpensesTableCreateCompanionBuilder,
          $$RecurringExpensesTableUpdateCompanionBuilder,
          (
            RecurringExpense,
            BaseReferences<
              _$AppDatabase,
              $RecurringExpensesTable,
              RecurringExpense
            >,
          ),
          RecurringExpense,
          PrefetchHooks Function()
        > {
  $$RecurringExpensesTableTableManager(
    _$AppDatabase db,
    $RecurringExpensesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecurringExpensesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> amountInCents = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<int?> dayOfMonth = const Value.absent(),
                Value<DateTime> referenceDate = const Value.absent(),
                Value<DateTime> nextDueDate = const Value.absent(),
                Value<String?> beneficiario = const Value.absent(),
                Value<String?> cnpj = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurringExpensesCompanion(
                id: id,
                description: description,
                amountInCents: amountInCents,
                category: category,
                frequency: frequency,
                dayOfMonth: dayOfMonth,
                referenceDate: referenceDate,
                nextDueDate: nextDueDate,
                beneficiario: beneficiario,
                cnpj: cnpj,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String description,
                required int amountInCents,
                required String category,
                required String frequency,
                Value<int?> dayOfMonth = const Value.absent(),
                required DateTime referenceDate,
                required DateTime nextDueDate,
                Value<String?> beneficiario = const Value.absent(),
                Value<String?> cnpj = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurringExpensesCompanion.insert(
                id: id,
                description: description,
                amountInCents: amountInCents,
                category: category,
                frequency: frequency,
                dayOfMonth: dayOfMonth,
                referenceDate: referenceDate,
                nextDueDate: nextDueDate,
                beneficiario: beneficiario,
                cnpj: cnpj,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecurringExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecurringExpensesTable,
      RecurringExpense,
      $$RecurringExpensesTableFilterComposer,
      $$RecurringExpensesTableOrderingComposer,
      $$RecurringExpensesTableAnnotationComposer,
      $$RecurringExpensesTableCreateCompanionBuilder,
      $$RecurringExpensesTableUpdateCompanionBuilder,
      (
        RecurringExpense,
        BaseReferences<
          _$AppDatabase,
          $RecurringExpensesTable,
          RecurringExpense
        >,
      ),
      RecurringExpense,
      PrefetchHooks Function()
    >;
typedef $$FilterFavoritesTableCreateCompanionBuilder =
    FilterFavoritesCompanion Function({
      required String id,
      required String nome,
      Value<String?> categorias,
      Value<DateTime?> dataInicio,
      Value<DateTime?> dataFim,
      Value<int?> valorMin,
      Value<int?> valorMax,
      Value<bool?> comComprovante,
      required DateTime criadoEm,
      required DateTime atualizadoEm,
      Value<int> rowid,
    });
typedef $$FilterFavoritesTableUpdateCompanionBuilder =
    FilterFavoritesCompanion Function({
      Value<String> id,
      Value<String> nome,
      Value<String?> categorias,
      Value<DateTime?> dataInicio,
      Value<DateTime?> dataFim,
      Value<int?> valorMin,
      Value<int?> valorMax,
      Value<bool?> comComprovante,
      Value<DateTime> criadoEm,
      Value<DateTime> atualizadoEm,
      Value<int> rowid,
    });

class $$FilterFavoritesTableFilterComposer
    extends Composer<_$AppDatabase, $FilterFavoritesTable> {
  $$FilterFavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categorias => $composableBuilder(
    column: $table.categorias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dataInicio => $composableBuilder(
    column: $table.dataInicio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dataFim => $composableBuilder(
    column: $table.dataFim,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get valorMin => $composableBuilder(
    column: $table.valorMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get valorMax => $composableBuilder(
    column: $table.valorMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get comComprovante => $composableBuilder(
    column: $table.comComprovante,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
    column: $table.criadoEm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get atualizadoEm => $composableBuilder(
    column: $table.atualizadoEm,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FilterFavoritesTableOrderingComposer
    extends Composer<_$AppDatabase, $FilterFavoritesTable> {
  $$FilterFavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categorias => $composableBuilder(
    column: $table.categorias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dataInicio => $composableBuilder(
    column: $table.dataInicio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dataFim => $composableBuilder(
    column: $table.dataFim,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get valorMin => $composableBuilder(
    column: $table.valorMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get valorMax => $composableBuilder(
    column: $table.valorMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get comComprovante => $composableBuilder(
    column: $table.comComprovante,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
    column: $table.criadoEm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get atualizadoEm => $composableBuilder(
    column: $table.atualizadoEm,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FilterFavoritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FilterFavoritesTable> {
  $$FilterFavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get categorias => $composableBuilder(
    column: $table.categorias,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dataInicio => $composableBuilder(
    column: $table.dataInicio,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dataFim =>
      $composableBuilder(column: $table.dataFim, builder: (column) => column);

  GeneratedColumn<int> get valorMin =>
      $composableBuilder(column: $table.valorMin, builder: (column) => column);

  GeneratedColumn<int> get valorMax =>
      $composableBuilder(column: $table.valorMax, builder: (column) => column);

  GeneratedColumn<bool> get comComprovante => $composableBuilder(
    column: $table.comComprovante,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  GeneratedColumn<DateTime> get atualizadoEm => $composableBuilder(
    column: $table.atualizadoEm,
    builder: (column) => column,
  );
}

class $$FilterFavoritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FilterFavoritesTable,
          FilterFavorite,
          $$FilterFavoritesTableFilterComposer,
          $$FilterFavoritesTableOrderingComposer,
          $$FilterFavoritesTableAnnotationComposer,
          $$FilterFavoritesTableCreateCompanionBuilder,
          $$FilterFavoritesTableUpdateCompanionBuilder,
          (
            FilterFavorite,
            BaseReferences<
              _$AppDatabase,
              $FilterFavoritesTable,
              FilterFavorite
            >,
          ),
          FilterFavorite,
          PrefetchHooks Function()
        > {
  $$FilterFavoritesTableTableManager(
    _$AppDatabase db,
    $FilterFavoritesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FilterFavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FilterFavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FilterFavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String?> categorias = const Value.absent(),
                Value<DateTime?> dataInicio = const Value.absent(),
                Value<DateTime?> dataFim = const Value.absent(),
                Value<int?> valorMin = const Value.absent(),
                Value<int?> valorMax = const Value.absent(),
                Value<bool?> comComprovante = const Value.absent(),
                Value<DateTime> criadoEm = const Value.absent(),
                Value<DateTime> atualizadoEm = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FilterFavoritesCompanion(
                id: id,
                nome: nome,
                categorias: categorias,
                dataInicio: dataInicio,
                dataFim: dataFim,
                valorMin: valorMin,
                valorMax: valorMax,
                comComprovante: comComprovante,
                criadoEm: criadoEm,
                atualizadoEm: atualizadoEm,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nome,
                Value<String?> categorias = const Value.absent(),
                Value<DateTime?> dataInicio = const Value.absent(),
                Value<DateTime?> dataFim = const Value.absent(),
                Value<int?> valorMin = const Value.absent(),
                Value<int?> valorMax = const Value.absent(),
                Value<bool?> comComprovante = const Value.absent(),
                required DateTime criadoEm,
                required DateTime atualizadoEm,
                Value<int> rowid = const Value.absent(),
              }) => FilterFavoritesCompanion.insert(
                id: id,
                nome: nome,
                categorias: categorias,
                dataInicio: dataInicio,
                dataFim: dataFim,
                valorMin: valorMin,
                valorMax: valorMax,
                comComprovante: comComprovante,
                criadoEm: criadoEm,
                atualizadoEm: atualizadoEm,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FilterFavoritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FilterFavoritesTable,
      FilterFavorite,
      $$FilterFavoritesTableFilterComposer,
      $$FilterFavoritesTableOrderingComposer,
      $$FilterFavoritesTableAnnotationComposer,
      $$FilterFavoritesTableCreateCompanionBuilder,
      $$FilterFavoritesTableUpdateCompanionBuilder,
      (
        FilterFavorite,
        BaseReferences<_$AppDatabase, $FilterFavoritesTable, FilterFavorite>,
      ),
      FilterFavorite,
      PrefetchHooks Function()
    >;
typedef $$DependentsTableCreateCompanionBuilder =
    DependentsCompanion Function({
      required String id,
      required String name,
      required String relationship,
      required DateTime birthDate,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$DependentsTableUpdateCompanionBuilder =
    DependentsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> relationship,
      Value<DateTime> birthDate,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$DependentsTableFilterComposer
    extends Composer<_$AppDatabase, $DependentsTable> {
  $$DependentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DependentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DependentsTable> {
  $$DependentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DependentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DependentsTable> {
  $$DependentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$DependentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DependentsTable,
          Dependent,
          $$DependentsTableFilterComposer,
          $$DependentsTableOrderingComposer,
          $$DependentsTableAnnotationComposer,
          $$DependentsTableCreateCompanionBuilder,
          $$DependentsTableUpdateCompanionBuilder,
          (
            Dependent,
            BaseReferences<_$AppDatabase, $DependentsTable, Dependent>,
          ),
          Dependent,
          PrefetchHooks Function()
        > {
  $$DependentsTableTableManager(_$AppDatabase db, $DependentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DependentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DependentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DependentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> relationship = const Value.absent(),
                Value<DateTime> birthDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DependentsCompanion(
                id: id,
                name: name,
                relationship: relationship,
                birthDate: birthDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String relationship,
                required DateTime birthDate,
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DependentsCompanion.insert(
                id: id,
                name: name,
                relationship: relationship,
                birthDate: birthDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DependentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DependentsTable,
      Dependent,
      $$DependentsTableFilterComposer,
      $$DependentsTableOrderingComposer,
      $$DependentsTableAnnotationComposer,
      $$DependentsTableCreateCompanionBuilder,
      $$DependentsTableUpdateCompanionBuilder,
      (Dependent, BaseReferences<_$AppDatabase, $DependentsTable, Dependent>),
      Dependent,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$ReceiptsTableTableManager get receipts =>
      $$ReceiptsTableTableManager(_db, _db.receipts);
  $$CnpjPreferencesTableTableManager get cnpjPreferences =>
      $$CnpjPreferencesTableTableManager(_db, _db.cnpjPreferences);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$RecurringExpensesTableTableManager get recurringExpenses =>
      $$RecurringExpensesTableTableManager(_db, _db.recurringExpenses);
  $$FilterFavoritesTableTableManager get filterFavorites =>
      $$FilterFavoritesTableTableManager(_db, _db.filterFavorites);
  $$DependentsTableTableManager get dependents =>
      $$DependentsTableTableManager(_db, _db.dependents);
}
