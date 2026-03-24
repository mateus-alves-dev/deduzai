import 'dart:io';
import 'dart:math' as math;

import 'package:deduzai/core/domain/models/ocr_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ocr_service.g.dart';

/// Maximum file size before compression (10 MB).
const _maxFileSizeBytes = 10 * 1024 * 1024;

/// Target file size after compression (2 MB).
const _targetFileSizeBytes = 2 * 1024 * 1024;

/// Minimum image dimension considered acceptable quality.
const _minQualityDimension = 720;

/// OCR processing timeout.
const _ocrTimeout = Duration(seconds: 15);

@riverpod
OcrService ocrService(Ref ref) => OcrService();

class OcrService {
  /// Checks if the image at [imagePath] has a dimension < [_minQualityDimension].
  ///
  /// Returns `true` if the image might be too low-quality for OCR.
  Future<bool> isLowQuality(String imagePath) async {
    try {
      final bytes = await File(imagePath).readAsBytes();
      final decoded = await compute(_decodeDimensions, bytes);
      if (decoded == null) return false;
      final minDim = math.min(decoded.$1, decoded.$2);
      return minDim < _minQualityDimension;
    } on Exception catch (_) {
      return false;
    }
  }

  /// Compresses the image at [imagePath] to ≤ 2 MB if it exceeds 10 MB.
  ///
  /// Returns the path to use for OCR (compressed or original).
  Future<String> compressIfNeeded(String imagePath) async {
    final file = File(imagePath);
    final size = await file.length();
    if (size <= _maxFileSizeBytes) return imagePath;

    final dir = await getApplicationDocumentsDirectory();
    final outPath = p.join(
      dir.path,
      'receipt_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    // Calculate quality to reach roughly _targetFileSizeBytes.
    final quality = math.min(85, (_targetFileSizeBytes / size * 100).round());

    final result = await FlutterImageCompress.compressAndGetFile(
      imagePath,
      outPath,
      quality: quality,
    );

    return result?.path ?? imagePath;
  }

  /// Saves [imageFile] to app documents dir and returns the new path.
  Future<String> saveImage(File imageFile) async {
    final dir = await getApplicationDocumentsDirectory();
    final dest = p.join(
      dir.path,
      'receipt_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    return (await imageFile.copy(dest)).path;
  }

  /// Runs on-device OCR on [imagePath] and returns an [OcrResult].
  ///
  /// Throws [TimeoutException] if processing exceeds 15 seconds.
  Future<OcrResult> processImage(String imagePath) async {
    final compressedPath = await compressIfNeeded(imagePath);

    final inputImage = InputImage.fromFilePath(compressedPath);
    final recognizer = TextRecognizer();

    try {
      final recognized =
          await recognizer.processImage(inputImage).timeout(_ocrTimeout);
      final rawText = recognized.text;
      return _parseText(rawText, compressedPath);
    } finally {
      await recognizer.close();
    }
  }

  /// Parses [rawText] from a Brazilian fiscal document and returns [OcrResult].
  @visibleForTesting
  OcrResult parseText(String rawText, String imagePath) =>
      _parseText(rawText, imagePath);

  OcrResult _parseText(String rawText, String imagePath) {
    final valor = _extractValor(rawText);
    final data = _extractData(rawText);
    final cnpj = _extractCnpj(rawText);
    final beneficiario = _extractBeneficiario(rawText);

    final hasKeyField = valor != null || cnpj != null;
    final hasAnyField =
        hasKeyField || data != null || beneficiario != null;

    final status = hasKeyField
        ? OcrStatus.success
        : hasAnyField
            ? OcrStatus.partial
            : OcrStatus.failure;

    return OcrResult(
      status: status,
      imagePath: imagePath,
      valor: valor,
      data: data,
      cnpj: cnpj,
      beneficiario: beneficiario,
    );
  }

  // ---------------------------------------------------------------------------
  // Parsing helpers
  // ---------------------------------------------------------------------------

  /// Extracts the total amount in centavos from a Brazilian receipt.
  int? _extractValor(String text) {
    // Prioritise lines containing TOTAL, VALOR, SUBTOTAL
    final totalPatterns = [
      RegExp(
        r'(?:total|valor\s*total|subtotal)[^\d]*(\d{1,3}(?:[.,]\d{3})*[.,]\d{2})',
        caseSensitive: false,
      ),
      RegExp(
        r'R\$\s*(\d{1,3}(?:[.,]\d{3})*[.,]\d{2})',
        caseSensitive: false,
      ),
    ];

    for (final pattern in totalPatterns) {
      final matches = pattern.allMatches(text).toList();
      if (matches.isNotEmpty) {
        // Take the last match (usually the grand total is at the bottom)
        final raw = matches.last.group(1)!;
        final cents = _parseBrMoney(raw);
        if (cents != null && cents > 0) return cents;
      }
    }
    return null;
  }

  int? _parseBrMoney(String raw) {
    // Handle both formats: 1.234,56 and 1234.56
    String normalized;
    if (raw.contains(',') && raw.contains('.')) {
      // 1.234,56 → Brazilian format
      normalized = raw.replaceAll('.', '').replaceAll(',', '.');
    } else if (raw.contains(',')) {
      // 1234,56 → decimal comma
      normalized = raw.replaceAll(',', '.');
    } else {
      normalized = raw;
    }
    final value = double.tryParse(normalized);
    if (value == null) return null;
    return (value * 100).round();
  }

  /// Extracts emission date from receipt text.
  DateTime? _extractData(String text) {
    final pattern = RegExp(r'(\d{2})[\/\-](\d{2})[\/\-](\d{4})');
    final match = pattern.firstMatch(text);
    if (match == null) return null;
    try {
      final raw = '${match.group(1)}/${match.group(2)}/${match.group(3)}';
      final date = DateFormat('dd/MM/yyyy').parseStrict(raw);
      final now = DateTime.now();
      // Sanity: reject future dates and dates > 10 years ago
      final tenYearsAgo = now.subtract(const Duration(days: 3650));
      if (date.isAfter(now) || date.isBefore(tenYearsAgo)) {
        return null;
      }
      return date;
    } on FormatException catch (_) {
      return null;
    }
  }

  /// Extracts CNPJ (returns 14-digit string, digits only).
  String? _extractCnpj(String text) {
    final pattern = RegExp(
      r'\b(\d{2})[.\s]?(\d{3})[.\s]?(\d{3})[\/\s]?(\d{4})[-\s]?(\d{2})\b',
    );
    final match = pattern.firstMatch(text);
    if (match == null) return null;
    return '${match.group(1)}${match.group(2)}${match.group(3)}${match.group(4)}${match.group(5)}';
  }

  /// Extracts beneficiary name (razão social) from receipt text.
  String? _extractBeneficiario(String text) {
    final lines = text.split('\n');
    if (lines.isEmpty) return null;

    // CNPJ line typically follows the company name; try first meaningful line
    for (final line in lines.take(5)) {
      final trimmed = line.trim();
      // Skip lines that look like addresses, dates, or are too short
      if (trimmed.length < 4) continue;
      if (RegExp(r'^\d').hasMatch(trimmed)) continue;
      if (trimmed.toLowerCase().contains('cnpj')) continue;
      if (trimmed.toLowerCase().contains('cpf')) continue;
      return trimmed.length > 100 ? trimmed.substring(0, 100) : trimmed;
    }
    return null;
  }
}

/// Isolate-safe helper to decode image dimensions.
(int, int)? _decodeDimensions(Uint8List bytes) {
  try {
    // Use codec info from raw bytes — check JPEG/PNG headers
    if (bytes.length < 24) return null;

    // PNG: 8-byte magic + IHDR chunk at offset 16
    if (bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      final w = (bytes[16] << 24) |
          (bytes[17] << 16) |
          (bytes[18] << 8) |
          bytes[19];
      final h = (bytes[20] << 24) |
          (bytes[21] << 16) |
          (bytes[22] << 8) |
          bytes[23];
      return (w, h);
    }

    // JPEG: scan for SOF marker (0xFF 0xC0/0xC2)
    for (var i = 2; i < bytes.length - 9; i++) {
      if (bytes[i] == 0xFF &&
          (bytes[i + 1] == 0xC0 || bytes[i + 1] == 0xC2)) {
        final h = (bytes[i + 5] << 8) | bytes[i + 6];
        final w = (bytes[i + 7] << 8) | bytes[i + 8];
        return (w, h);
      }
    }
  } on Exception catch (_) {}
  return null;
}
