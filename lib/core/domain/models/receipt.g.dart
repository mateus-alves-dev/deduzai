// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Receipt _$ReceiptFromJson(Map<String, dynamic> json) => _Receipt(
  id: json['id'] as String,
  expenseId: json['expenseId'] as String,
  localPath: json['localPath'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ReceiptToJson(_Receipt instance) => <String, dynamic>{
  'id': instance.id,
  'expenseId': instance.expenseId,
  'localPath': instance.localPath,
  'createdAt': instance.createdAt.toIso8601String(),
};
