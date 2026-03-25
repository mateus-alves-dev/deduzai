import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

Color colorForCategory(DeductionCategory category) => switch (category) {
      DeductionCategory.saude => AppColors.categorySaude,
      DeductionCategory.educacao => AppColors.categoryEducacao,
      DeductionCategory.pensaoAlimenticia => AppColors.categoryPensao,
      DeductionCategory.previdenciaPrivada => AppColors.categoryPrevidencia,
      DeductionCategory.dependentes => AppColors.categoryDependentes,
      DeductionCategory.previdenciaSocial =>
        AppColors.categoryPrevidenciaSocial,
      DeductionCategory.doacoesIncentivadas => AppColors.categoryDoacoes,
      DeductionCategory.livroCaixa => AppColors.categoryLivroCaixa,
    };

IconData iconForCategory(DeductionCategory category) => switch (category) {
      DeductionCategory.saude => Icons.health_and_safety_outlined,
      DeductionCategory.educacao => Icons.school_outlined,
      DeductionCategory.pensaoAlimenticia => Icons.family_restroom_outlined,
      DeductionCategory.previdenciaPrivada => Icons.savings_outlined,
      DeductionCategory.dependentes => Icons.people_outline,
      DeductionCategory.previdenciaSocial => Icons.account_balance_outlined,
      DeductionCategory.doacoesIncentivadas =>
        Icons.volunteer_activism_outlined,
      DeductionCategory.livroCaixa => Icons.menu_book_outlined,
    };
