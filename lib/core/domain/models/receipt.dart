import 'package:deduzai/core/domain/models/ocr_result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'receipt.freezed.dart';
part 'receipt.g.dart';

@freezed
abstract class Receipt with _$Receipt {
  const factory Receipt({
    required String id,
    required String expenseId,
    required String localPath,
    required DateTime createdAt,
    String? mimeType,
    int? tamanhoBytes,
    OcrStatus? ocrStatus,
  }) = _Receipt;

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);
}
