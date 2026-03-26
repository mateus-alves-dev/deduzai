import 'dart:async' show TimeoutException;
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
const int _maxFileSizeBytes = 10 * 1024 * 1024;

/// Target file size after compression (2 MB).
const int _targetFileSizeBytes = 2 * 1024 * 1024;

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
      final recognized = await recognizer
          .processImage(inputImage)
          .timeout(_ocrTimeout);
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

    // success requires valor; partial if any other field was extracted
    final hasAnyField =
        valor != null || cnpj != null || data != null || beneficiario != null;

    final status = valor != null
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

  /// Guard: amount must be > 0 centavos and ≤ R$ 1.000.000,00
  static const _minCentavos = 1;
  static const _maxCentavos = 100000000;

  bool _isValidAmount(int cents) =>
      cents >= _minCentavos && cents <= _maxCentavos;

  /// Extracts the total amount in centavos from a Brazilian receipt.
  int? _extractValor(String text) {
    const keywords =
        r'total\s*a\s*pagar|valor\s*a\s*pagar|total\s*geral'
        r'|valor\s*total|valor\s*l[ií]quido|total\s*due'
        r'|vlr\s*total|v\.\s*total|tot\s*geral'
        r'|vlr\s*a\s*pagar|valor\s*a\s*cobrar|valor\s*bruto'
        r'|a\s*pagar|total|subtotal';
    const amount = r'(\d{1,3}(?:[.,]\d{3})*[.,]\d{2})';

    // Stage 1a: keyword + amount on same line
    final keywordPattern = RegExp(
      '(?:$keywords)[^\\d]*$amount',
      caseSensitive: false,
    );
    int? best;
    for (final m in keywordPattern.allMatches(text)) {
      final cents = _parseBrMoney(m.group(1)!);
      if (cents != null && _isValidAmount(cents)) {
        if (best == null || cents > best) best = cents;
      }
    }
    if (best != null) return best;

    // Stage 1b: keyword on one line, amount on the next line
    final lines = text.split('\n');
    final keywordLinePattern = RegExp(keywords, caseSensitive: false);
    final amountLinePattern = RegExp(
      r'^\s*R?\$?\s*(\d{1,3}(?:[.,]\d{3})*[.,]\d{2})\s*$',
    );
    for (var i = 0; i < lines.length - 1; i++) {
      if (keywordLinePattern.hasMatch(lines[i])) {
        final nextMatch = amountLinePattern.firstMatch(lines[i + 1]);
        if (nextMatch != null) {
          final cents = _parseBrMoney(nextMatch.group(1)!);
          if (cents != null && _isValidAmount(cents)) {
            if (best == null || cents > best) best = cents;
          }
        }
      }
    }
    if (best != null) return best;

    // Stage 2: fallback to any R$ amount — take the largest value found
    final currencyPattern = RegExp(
      r'R\$\s*(\d{1,3}(?:[.,]\d{3})*[.,]\d{2})',
      caseSensitive: false,
    );
    for (final m in currencyPattern.allMatches(text)) {
      final cents = _parseBrMoney(m.group(1)!);
      if (cents != null && _isValidAmount(cents)) {
        if (best == null || cents > best) best = cents;
      }
    }
    if (best != null) return best;

    // Stage 3: any standalone monetary amount — take the largest value
    final standalonePattern = RegExp(
      r'(\d{1,3}(?:[.,]\d{3})*[.,]\d{2})',
    );
    for (final m in standalonePattern.allMatches(text)) {
      final cents = _parseBrMoney(m.group(1)!);
      if (cents != null && _isValidAmount(cents)) {
        if (best == null || cents > best) best = cents;
      }
    }
    return best;
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
    final now = DateTime.now();
    final tenYearsAgo = now.subtract(const Duration(days: 3650));

    // Supports DD/MM/YYYY, DD-MM-YYYY, DD.MM.YYYY, and DD/MM/YY
    final pattern = RegExp(r'(\d{2})[\/\-\.](\d{2})[\/\-\.](\d{2,4})');

    // Keyword priority: prefer dates near emission-related keywords
    final keywordPattern = RegExp(
      r'(?:emiss[aã]o|data\s*:|dt\s*emiss|data\s*emiss)',
      caseSensitive: false,
    );
    final keywordMatch = keywordPattern.firstMatch(text);
    if (keywordMatch != null) {
      // Look for a date within ~30 chars after the keyword
      final searchEnd = math.min(
        text.length,
        keywordMatch.end + 30,
      );
      final nearbyText = text.substring(keywordMatch.end, searchEnd);
      final nearbyDate = pattern.firstMatch(nearbyText);
      if (nearbyDate != null) {
        final parsed = _parseDate(nearbyDate, now, tenYearsAgo);
        if (parsed != null) return parsed;
      }
    }

    // Collect all valid dates and prefer the most recent one
    DateTime? bestDate;
    for (final m in pattern.allMatches(text)) {
      final parsed = _parseDate(m, now, tenYearsAgo);
      if (parsed != null) {
        if (bestDate == null || parsed.isAfter(bestDate)) {
          bestDate = parsed;
        }
      }
    }
    return bestDate;
  }

  /// Parses a date match with support for 2- and 4-digit years.
  DateTime? _parseDate(RegExpMatch match, DateTime now, DateTime tenYearsAgo) {
    try {
      final day = match.group(1)!;
      final month = match.group(2)!;
      final rawYear = match.group(3)!;

      String yearStr;
      if (rawYear.length == 2) {
        final yy = int.parse(rawYear);
        yearStr = (yy <= 50 ? 2000 + yy : 1900 + yy).toString();
      } else {
        yearStr = rawYear;
      }

      final raw = '$day/$month/$yearStr';
      final date = DateFormat('dd/MM/yyyy').parseStrict(raw);
      if (date.isAfter(now) || date.isBefore(tenYearsAgo)) return null;
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

    String? fallback;

    for (final match in pattern.allMatches(text)) {
      final raw =
          '${match.group(1)}${match.group(2)}'
          '${match.group(3)}${match.group(4)}${match.group(5)}';
      fallback ??= raw;
      if (_validateCnpj(raw)) return raw;

      // Try OCR error corrections on the raw matched text
      final rawText = match.group(0)!;
      final corrected = _applyCnpjOcrFixes(rawText);
      if (corrected != null && _validateCnpj(corrected)) return corrected;
    }

    // Return first match even if invalid — better than nothing
    return fallback;
  }

  /// Validates CNPJ using modulo 11 algorithm.
  bool _validateCnpj(String cnpj) {
    if (cnpj.length != 14) return false;
    final digits = cnpj.codeUnits.map((c) => c - 48).toList();
    if (digits.any((d) => d < 0 || d > 9)) return false;

    // First check digit
    const weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    var sum = 0;
    for (var i = 0; i < 12; i++) {
      sum += digits[i] * weights1[i];
    }
    var remainder = sum % 11;
    final check1 = remainder < 2 ? 0 : 11 - remainder;
    if (digits[12] != check1) return false;

    // Second check digit
    const weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    sum = 0;
    for (var i = 0; i < 13; i++) {
      sum += digits[i] * weights2[i];
    }
    remainder = sum % 11;
    final check2 = remainder < 2 ? 0 : 11 - remainder;
    return digits[13] == check2;
  }

  /// Applies common OCR substitutions and returns a 14-digit
  /// string if possible.
  String? _applyCnpjOcrFixes(String rawText) {
    final fixed = rawText
        .replaceAll('O', '0')
        .replaceAll('I', '1')
        .replaceAll('l', '1')
        .replaceAll('S', '5')
        .replaceAll('B', '8');
    final digits = fixed.replaceAll(RegExp(r'[^\d]'), '');
    return digits.length == 14 ? digits : null;
  }

  /// Extracts beneficiary name (razão social) from receipt text.
  String? _extractBeneficiario(String text) {
    final lines = text.split('\n');
    if (lines.isEmpty) return null;

    // Patterns that indicate a line is NOT a company name
    final skipPatterns = [
      RegExp(r'^\d'), // starts with digit (address number, date, amount)
      RegExp(r'cnpj|cpf|ie\s*:|insc\s*:', caseSensitive: false),
      RegExp(
        r'rua |av\.|avenida |travessa |rod\.|rodovia ',
        caseSensitive: false,
      ),
      RegExp(r'cep\s*:?\s*\d{5}', caseSensitive: false),
      RegExp(r'fone|tel\.|telefone', caseSensitive: false),
      RegExp(r'^\d{2}[\/\-\.]\d{2}[\/\-\.]\d{2,4}'), // date line
      RegExp(r'R\$'), // amount line
      RegExp('inscri[cç][aã]o', caseSensitive: false),
      RegExp('^valor', caseSensitive: false),
      RegExp('^qtd', caseSensitive: false),
      RegExp('^item', caseSensitive: false),
      RegExp('^descri[cç][aã]o', caseSensitive: false),
      RegExp(r'cupom\s*fiscal', caseSensitive: false),
      RegExp('nf-?e', caseSensitive: false),
      RegExp(r'nota\s*fiscal', caseSensitive: false),
      RegExp('extrato', caseSensitive: false),
      RegExp('comprovante', caseSensitive: false),
    ];

    // Keyword search: look for explicit labels in the first 12 lines
    final keywordPattern = RegExp(
      r'(?:raz[aã]o\s*social|nome\s*fantasia|nome)\s*:?\s*(.*)',
      caseSensitive: false,
    );
    for (final line in lines.take(12)) {
      final match = keywordPattern.firstMatch(line.trim());
      if (match != null) {
        final value = match.group(1)!.trim();
        if (value.length >= 3) {
          return value.length > 80 ? value.substring(0, 80) : value;
        }
      }
    }

    // Scoring system for candidate lines
    int? bestScore;
    String? candidate;

    for (final line in lines.take(12)) {
      final trimmed = line.trim();
      if (trimmed.length < 4) continue;
      if (skipPatterns.any((p) => p.hasMatch(trimmed))) continue;

      final score = _scoreBeneficiarioLine(trimmed);
      if (bestScore == null || score > bestScore) {
        bestScore = score;
        candidate = trimmed.length > 80 ? trimmed.substring(0, 80) : trimmed;
      }
    }

    return candidate;
  }

  /// Scores a candidate beneficiário line.
  int _scoreBeneficiarioLine(String line) {
    var score = 0;

    final isUpperCase =
        line == line.toUpperCase() && line.contains(RegExp('[A-Z]'));
    if (isUpperCase) score += 2;
    if (line.length >= 6) score += 1;

    final digitCount = line.codeUnits.where((c) => c >= 48 && c <= 57).length;
    if (digitCount > line.length * 0.5) score -= 1;
    if (line.length < 6) score -= 1;

    return score;
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
      final w =
          (bytes[16] << 24) | (bytes[17] << 16) | (bytes[18] << 8) | bytes[19];
      final h =
          (bytes[20] << 24) | (bytes[21] << 16) | (bytes[22] << 8) | bytes[23];
      return (w, h);
    }

    // JPEG: scan for SOF marker (0xFF 0xC0/0xC2)
    for (var i = 2; i < bytes.length - 9; i++) {
      if (bytes[i] == 0xFF && (bytes[i + 1] == 0xC0 || bytes[i + 1] == 0xC2)) {
        final h = (bytes[i + 5] << 8) | bytes[i + 6];
        final w = (bytes[i + 7] << 8) | bytes[i + 8];
        return (w, h);
      }
    }
  } on Exception catch (_) {}
  return null;
}
