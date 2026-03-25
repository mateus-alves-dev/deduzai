import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:deduzai/core/theme/category_utils.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    required this.selected,
    required this.onChanged,
    this.showError = false,
    super.key,
  });

  final DeductionCategory? selected;
  final ValueChanged<DeductionCategory> onChanged;
  final bool showError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categoria',
          style: AppTextStyles.labelMedium.copyWith(
            color: showError
                ? theme.colorScheme.error
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: DeductionCategory.values.map((cat) {
            final isSelected = selected == cat;
            final catColor = colorForCategory(cat);

            return ChoiceChip(
              label: Text(cat.label),
              avatar: Icon(
                iconForCategory(cat),
                size: 18,
                color: isSelected ? Colors.white : catColor,
              ),
              selected: isSelected,
              selectedColor: catColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                fontSize: 13,
              ),
              backgroundColor: catColor.withValues(alpha: 0.08),
              side: BorderSide(
                color: isSelected
                    ? catColor
                    : catColor.withValues(alpha: 0.3),
              ),
              showCheckmark: false,
              onSelected: (_) => onChanged(cat),
            );
          }).toList(),
        ),
        if (showError) ...[
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.sm),
            child: Text(
              'Selecione uma categoria',
              style: TextStyle(
                color: theme.colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
