import 'dart:ui';

import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/theme/app_colors.dart';

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
