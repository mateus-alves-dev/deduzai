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
  mimeType: json['mimeType'] as String?,
  tamanhoBytes: (json['tamanhoBytes'] as num?)?.toInt(),
  ocrStatus: $enumDecodeNullable(_$OcrStatusEnumMap, json['ocrStatus']),
);

Map<String, dynamic> _$ReceiptToJson(_Receipt instance) => <String, dynamic>{
  'id': instance.id,
  'expenseId': instance.expenseId,
  'localPath': instance.localPath,
  'createdAt': instance.createdAt.toIso8601String(),
  'mimeType': instance.mimeType,
  'tamanhoBytes': instance.tamanhoBytes,
  'ocrStatus': _$OcrStatusEnumMap[instance.ocrStatus],
};

const _$OcrStatusEnumMap = {
  OcrStatus.success: 'success',
  OcrStatus.partial: 'partial',
  OcrStatus.failure: 'failure',
};
