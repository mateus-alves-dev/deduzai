// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecurringExpense _$RecurringExpenseFromJson(Map<String, dynamic> json) =>
    _RecurringExpense(
      id: json['id'] as String,
      description: json['description'] as String,
      amountInCents: (json['amountInCents'] as num).toInt(),
      category: $enumDecode(_$DeductionCategoryEnumMap, json['category']),
      frequency: $enumDecode(_$RecurrenceFrequencyEnumMap, json['frequency']),
      referenceDate: DateTime.parse(json['referenceDate'] as String),
      nextDueDate: DateTime.parse(json['nextDueDate'] as String),
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      dayOfMonth: (json['dayOfMonth'] as num?)?.toInt(),
      beneficiario: json['beneficiario'] as String?,
      cnpj: json['cnpj'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$RecurringExpenseToJson(_RecurringExpense instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'amountInCents': instance.amountInCents,
      'category': _$DeductionCategoryEnumMap[instance.category]!,
      'frequency': _$RecurrenceFrequencyEnumMap[instance.frequency]!,
      'referenceDate': instance.referenceDate.toIso8601String(),
      'nextDueDate': instance.nextDueDate.toIso8601String(),
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'dayOfMonth': instance.dayOfMonth,
      'beneficiario': instance.beneficiario,
      'cnpj': instance.cnpj,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

const _$DeductionCategoryEnumMap = {
  DeductionCategory.saude: 'saude',
  DeductionCategory.educacao: 'educacao',
  DeductionCategory.pensaoAlimenticia: 'pensaoAlimenticia',
  DeductionCategory.previdenciaPrivada: 'previdenciaPrivada',
  DeductionCategory.dependentes: 'dependentes',
  DeductionCategory.previdenciaSocial: 'previdenciaSocial',
  DeductionCategory.doacoesIncentivadas: 'doacoesIncentivadas',
  DeductionCategory.livroCaixa: 'livroCaixa',
};

const _$RecurrenceFrequencyEnumMap = {
  RecurrenceFrequency.semanal: 'semanal',
  RecurrenceFrequency.quinzenal: 'quinzenal',
  RecurrenceFrequency.mensal: 'mensal',
  RecurrenceFrequency.anual: 'anual',
};
