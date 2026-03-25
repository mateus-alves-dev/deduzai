import 'dart:ui';

abstract final class AppColors {
  // Primary — green evoking financial growth
  static const primary = Color(0xFF2E7D32);
  static const primaryLight = Color(0xFF66BB6A);
  static const primaryDark = Color(0xFF1B5E20);

  // Secondary — warm amber for CTAs
  static const secondary = Color(0xFFFFA000);

  // Semantic
  static const error = Color(0xFFD32F2F);
  static const warning = Color(0xFFF9A825);
  static const success = Color(0xFF388E3C);

  // Category colors (charts, pills)
  static const categorySaude = Color(0xFFE53935);
  static const categoryEducacao = Color(0xFF1E88E5);
  static const categoryPensao = Color(0xFF8E24AA);
  static const categoryPrevidencia = Color(0xFF43A047);
  static const categoryDependentes = Color(0xFF757575);
  static const categoryPrevidenciaSocial = Color(0xFF00897B);
  static const categoryDoacoes = Color(0xFFFB8C00);
  static const categoryLivroCaixa = Color(0xFF5C6BC0);
}
