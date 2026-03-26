import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  static const _baseStyle = TextStyle(fontFamily: 'Roboto');

  static final TextStyle headlineLarge = _baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.25,
  );

  static final TextStyle headlineMedium = _baseStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.29,
  );

  static final TextStyle titleLarge = _baseStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.27,
  );

  static final TextStyle titleMedium = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  /// For currency/amount display with tabular figures.
  static final TextStyle amountDisplay = _baseStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.33,
    fontFeatures: [const FontFeature.tabularFigures()],
  );

  static final TextStyle bodyLarge = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static final TextStyle bodyMedium = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.43,
  );

  static final TextStyle labelMedium = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
  );
}
