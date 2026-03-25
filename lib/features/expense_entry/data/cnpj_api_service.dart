import 'dart:convert';

import 'package:deduzai/core/domain/models/cnpj_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'cnpj_api_service.g.dart';

/// Riverpod provider for [CnpjApiService].
@riverpod
CnpjApiService cnpjApiService(Ref ref) => CnpjApiService();

/// Service for fetching CNPJ information from BrasilAPI.
///
/// Implements silent fallback: errors are logged but not thrown.
/// Returns null if the API is unavailable or the CNPJ is invalid.
class CnpjApiService {
  static const _baseUrl = 'https://brasilapi.com.br/api/cnpj/v1';
  static const _timeout = Duration(seconds: 5);

  /// Fetches CNPJ information from BrasilAPI.
  ///
  /// Returns null if:
  /// - Input is invalid (not 14 digits)
  /// - API request times out
  /// - API returns error (404, 5xx, etc.)
  /// - Network error occurs
  ///
  /// This method never throws; all errors are silent (suitable for offline-first).
  Future<CnpjInfo?> fetchCnpj(String cnpj) async {
    try {
      // Sanitize: only digits, must be 14 chars
      final sanitized = cnpj.replaceAll(RegExp(r'\D'), '');
      if (sanitized.length != 14) {
        return null;
      }

      final url = Uri.parse('$_baseUrl/$sanitized');
      final response = await http.get(url).timeout(_timeout);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return CnpjInfo.fromJson(json);
      }

      // 404 or other HTTP errors: CNPJ not found or API error
      return null;
    } on FormatException {
      // Invalid JSON response
      return null;
    } catch (e) {
      // Network error, timeout, or other exception
      return null;
    }
  }
}
