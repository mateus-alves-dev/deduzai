// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Expense _$ExpenseFromJson(Map<String, dynamic> json) => _Expense(
  id: json['id'] as String,
  date: DateTime.parse(json['date'] as String),
  category: $enumDecode(_$DeductionCategoryEnumMap, json['category']),
  amountInCents: (json['amountInCents'] as num).toInt(),
  description: json['description'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  receiptPath: json['receiptPath'] as String?,
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$ExpenseToJson(_Expense instance) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date.toIso8601String(),
  'category': _$DeductionCategoryEnumMap[instance.category]!,
  'amountInCents': instance.amountInCents,
  'description': instance.description,
  'createdAt': instance.createdAt.toIso8601String(),
  'receiptPath': instance.receiptPath,
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

const _$DeductionCategoryEnumMap = {
  DeductionCategory.saude: 'saude',
  DeductionCategory.educacao: 'educacao',
  DeductionCategory.pensaoAlimenticia: 'pensaoAlimenticia',
  DeductionCategory.previdenciaPrivada: 'previdenciaPrivada',
  DeductionCategory.dependentes: 'dependentes',
};
