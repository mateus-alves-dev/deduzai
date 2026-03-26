import 'package:deduzai/core/domain/models/annual_summary.dart';
import 'package:deduzai/core/theme/app_colors.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/features/annual_summary/presentation/widgets/category_color_utils.dart';
import 'package:flutter/material.dart';

class CategoryBreakdownBar extends StatelessWidget {
  const CategoryBreakdownBar({required this.summary, super.key});

  final AnnualSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = summary.totalDeductibleInCents;

    final segments = summary.categories.map((c) {
      return _BarSegment(
        color: colorForCategory(c.category),
        fraction: total > 0 ? c.deductibleInCents / total : 0.0,
        label: c.category.label,
      );
    }).toList();

    // Add dependent deduction segment if present.
    if (summary.dependentDeductionInCents > 0) {
      segments.add(
        _BarSegment(
          color: AppColors.categoryDependentes,
          fraction:
              total > 0 ? summary.dependentDeductionInCents / total : 0.0,
          label: 'Dependentes',
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CustomPaint(
              size: const Size(double.infinity, 20),
              painter: _CategoryBarPainter(
                segments: segments,
                fallbackColor: theme.colorScheme.surfaceContainerHighest,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.xs,
            children: segments
                .map((s) => _LegendItem(color: s.color, label: s.label))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _BarSegment {
  const _BarSegment({
    required this.color,
    required this.fraction,
    required this.label,
  });

  final Color color;
  final double fraction;
  final String label;
}

class _CategoryBarPainter extends CustomPainter {
  _CategoryBarPainter({required this.segments, required this.fallbackColor});

  final List<_BarSegment> segments;
  final Color fallbackColor;

  static const _gap = 1.5;

  @override
  void paint(Canvas canvas, Size size) {
    if (segments.isEmpty) {
      canvas.drawRect(
        Offset.zero & size,
        Paint()..color = fallbackColor,
      );
      return;
    }

    final totalGaps = _gap * (segments.length - 1);
    final usableWidth = size.width - totalGaps;
    var x = 0.0;

    for (var i = 0; i < segments.length; i++) {
      final segmentWidth = segments[i].fraction * usableWidth;
      if (segmentWidth > 0) {
        canvas.drawRect(
          Rect.fromLTWH(x, 0, segmentWidth, size.height),
          Paint()..color = segments[i].color,
        );
      }
      x += segmentWidth;
      if (i < segments.length - 1) {
        x += _gap;
      }
    }
  }

  @override
  bool shouldRepaint(_CategoryBarPainter oldDelegate) =>
      !identical(segments, oldDelegate.segments);
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
