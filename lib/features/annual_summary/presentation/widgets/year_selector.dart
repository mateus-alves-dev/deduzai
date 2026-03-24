import 'package:flutter/material.dart';

/// Compact prev/next year picker.
class YearSelector extends StatelessWidget {
  const YearSelector({
    required this.year,
    required this.onChanged,
    super.key,
  });

  final int year;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          tooltip: 'Ano anterior',
          onPressed: () => onChanged(year - 1),
        ),
        Text(
          '$year',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          tooltip: 'Próximo ano',
          onPressed: year < currentYear ? () => onChanged(year + 1) : null,
        ),
      ],
    );
  }
}
