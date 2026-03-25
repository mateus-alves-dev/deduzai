import 'package:freezed_annotation/freezed_annotation.dart';

part 'cnpj_info.freezed.dart';
part 'cnpj_info.g.dart';

/// Domain model representing CNPJ information fetched from BrasilAPI.
///
/// This is populated when a valid CNPJ is successfully looked up via the
/// BrasilAPI endpoint.
@freezed
abstract class CnpjInfo with _$CnpjInfo {
  const factory CnpjInfo({
    required String cnpj,
    required String razaoSocial,
    required int cnaeFiscal,
    required String cnaeFiscalDescricao,
    String? nomeFantasia,
  }) = _CnpjInfo;

  factory CnpjInfo.fromJson(Map<String, dynamic> json) =>
      _$CnpjInfoFromJson(json);
}
