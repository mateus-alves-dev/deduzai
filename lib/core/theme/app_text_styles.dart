import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  static const _baseStyle = TextStyle(fontFamily: 'Roboto');

  static final headlineLarge = _baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.25,
  );

  static final headlineMedium = _baseStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.29,
  );

  static final titleLarge = _baseStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.27,
  );

  static final titleMedium = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  /// For currency/amount display with tabular figures.
  static final amountDisplay = _baseStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.33,
    fontFeatures: [const FontFeature.tabularFigures()],
  );

  static final bodyLarge = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static final bodyMedium = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.43,
  );

  static final labelMedium = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
  );
}
