import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double? loadingState;
  final String loadingLabel;
  final Color? color;
  final Color? backgroundColor;
  final Color? labelColor;

  const LoadingWidget({
    super.key,
    this.loadingState,
    required this.loadingLabel,
    this.color,
    this.backgroundColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final effectiveColor = color ?? colors.primary;
    final effectiveBgColor = backgroundColor ?? colors.primaryContainer;

    final double? progressValue = loadingState != null
        ? (loadingState! > 1.0 ? (loadingState! / 100.0) : loadingState!).clamp(0.0, 1.0)
        : null;

    Widget buildBar(double? value) => LinearProgressIndicator(
      value: value,
      borderRadius: const BorderRadius.all(Radius.circular(99)),
      backgroundColor: effectiveBgColor,
      color: effectiveColor,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: 4,
          child: progressValue == null
              ? buildBar(null)
              : TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: progressValue),
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            builder: (_, value, __) => buildBar(value),
          ),
        ),
        if (loadingLabel.isNotEmpty) ...[
          const SizedBox(height: 12),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              loadingLabel,
              key: ValueKey<String>(loadingLabel),
              style: theme.textTheme.labelMedium?.copyWith(color: labelColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }
}