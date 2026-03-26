import 'dart:math' as math;

import 'package:deduzai/core/domain/models/annual_summary.dart';
import 'package:deduzai/core/theme/category_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({required this.categories, super.key});

  final List<CategorySummary> categories;

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int? _tappedIndex;

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return const _EmptyPie(message: 'Nenhum gasto neste mês');
    }

    final total = widget.categories.fold<int>(0, (s, c) => s + c.totalInCents);
    if (total == 0) return const _EmptyPie(message: 'Nenhum gasto neste mês');

    final segments = widget.categories.map((c) {
      return _PieSegment(
        color: colorForCategory(c.category),
        fraction: c.totalInCents / total,
        label: c.category.label,
      );
    }).toList();

    return Column(
      children: [
        GestureDetector(
          onTapUp: (details) {
            final box = context.findRenderObject()! as RenderBox;
            final local = box.globalToLocal(details.globalPosition);
            final center = Offset(box.size.width / 2, 100);
            final angle = math.atan2(
              local.dy - center.dy,
              local.dx - center.dx,
            );
            final normalizedAngle =
                (angle + math.pi / 2 + 2 * math.pi) % (2 * math.pi);
            var accumulated = 0.0;
            for (var i = 0; i < segments.length; i++) {
              accumulated += segments[i].fraction * 2 * math.pi;
              if (normalizedAngle <= accumulated) {
                setState(() => _tappedIndex = _tappedIndex == i ? null : i);
                return;
              }
            }
          },
          child: SizedBox(
            height: 200,
            child: CustomPaint(
              size: const Size(double.infinity, 200),
              painter: _PiePainter(
                segments: segments,
                tappedIndex: _tappedIndex,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 4,
          alignment: WrapAlignment.center,
          children: [
            for (var i = 0; i < segments.length; i++)
              _LegendItem(
                color: segments[i].color,
                label: segments[i].label,
                highlighted: _tappedIndex == i,
              ),
          ],
        ),
        if (_tappedIndex != null && _tappedIndex! < widget.categories.length)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: _TooltipCard(summary: widget.categories[_tappedIndex!]),
          ),
      ],
    );
  }
}

class _PieSegment {
  const _PieSegment({
    required this.color,
    required this.fraction,
    required this.label,
  });

  final Color color;
  final double fraction;
  final String label;
}

class _PiePainter extends CustomPainter {
  _PiePainter({required this.segments, this.tappedIndex});

  final List<_PieSegment> segments;
  final int? tappedIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 8;

    var startAngle = -math.pi / 2;
    for (var i = 0; i < segments.length; i++) {
      final sweep = segments[i].fraction * 2 * math.pi;
      final paint = Paint()
        ..color = segments[i].color
        ..style = PaintingStyle.fill;

      // Explode tapped segment slightly
      var drawCenter = center;
      if (i == tappedIndex) {
        final midAngle = startAngle + sweep / 2;
        drawCenter =
            center +
            Offset(
              math.cos(midAngle) * 8,
              math.sin(midAngle) * 8,
            );
      }

      final path = Path()
        ..moveTo(drawCenter.dx, drawCenter.dy)
        ..arcTo(
          Rect.fromCircle(center: drawCenter, radius: radius),
          startAngle,
          sweep,
          false,
        )
        ..close();

      canvas.drawPath(path, paint);

      // Gap between segments
      final gapPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawPath(path, gapPaint);

      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(_PiePainter old) =>
      segments != old.segments || tappedIndex != old.tappedIndex;
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    required this.highlighted,
  });

  final Color color;
  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: highlighted ? 10 : 8,
          height: highlighted ? 10 : 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: highlighted ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _TooltipCard extends StatelessWidget {
  const _TooltipCard({required this.summary});

  final CategorySummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currency = NumberFormat.currency(locale: 'pt_BR', symbol: r'R$');
    final color = colorForCategory(summary.category);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            summary.category.label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            currency.format(summary.totalInCents / 100),
            style: theme.textTheme.labelMedium?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _EmptyPie extends StatelessWidget {
  const _EmptyPie({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 180,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.pie_chart_outline,
              size: 64,
              color: theme.colorScheme.outlineVariant,
            ),
            const SizedBox(height: 8),
            Text(message, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
