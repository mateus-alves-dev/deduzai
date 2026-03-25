import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Standardized AppBar for all DeduzAí screens.
///
/// Flat/clean style with subtle background, prominent title,
/// and consistent action spacing.
class DeduzaiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DeduzaiAppBar({
    required this.title,
    this.actions,
    this.leading,
    this.bottom,
    this.automaticallyImplyLeading = true,
    super.key,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      title: Text(
        title,
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions != null
          ? [...actions!, const SizedBox(width: AppSpacing.sm)]
          : null,
      bottom: bottom,
      backgroundColor: colorScheme.surfaceContainerLow,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: Border(
        bottom: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
