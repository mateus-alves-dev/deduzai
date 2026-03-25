// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cnpj_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CnpjInfo _$CnpjInfoFromJson(Map<String, dynamic> json) => _CnpjInfo(
  cnpj: json['cnpj'] as String,
  razaoSocial: json['razaoSocial'] as String,
  cnaeFiscal: (json['cnaeFiscal'] as num).toInt(),
  cnaeFiscalDescricao: json['cnaeFiscalDescricao'] as String,
  nomeFantasia: json['nomeFantasia'] as String?,
);

Map<String, dynamic> _$CnpjInfoToJson(_CnpjInfo instance) => <String, dynamic>{
  'cnpj': instance.cnpj,
  'razaoSocial': instance.razaoSocial,
  'cnaeFiscal': instance.cnaeFiscal,
  'cnaeFiscalDescricao': instance.cnaeFiscalDescricao,
  'nomeFantasia': instance.nomeFantasia,
};
