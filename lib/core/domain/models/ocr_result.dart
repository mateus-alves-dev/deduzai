import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocr_result.freezed.dart';

enum OcrStatus {
  /// At least one key field extracted (valor or cnpj).
  success,

  /// Some fields extracted but not all key fields.
  partial,

  /// No fields could be extracted.
  failure,
}

@freezed
abstract class OcrResult with _$OcrResult {
  const factory OcrResult({
    required OcrStatus status,

    /// Path to the (possibly compressed) image saved on disk.
    required String imagePath,

    /// Extracted amount in centavos.
    int? valor,

    /// Extracted expense date.
    DateTime? data,

    /// Extracted CNPJ (digits only, 14 chars).
    String? cnpj,

    /// Extracted issuer name / beneficiário.
    String? beneficiario,
  }) = _OcrResult;
}
