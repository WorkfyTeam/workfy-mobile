import 'package:material_ui/material_ui.dart';

enum AppButtonVariant {
  primary,
  secondary,
  ghost,
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonVariant variant;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double height;
  final double? width;
  final BorderRadius? borderRadius;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    bool isOutlined = false,
    AppButtonVariant? variant,
    this.leadingIcon,
    this.trailingIcon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.height = 50.0,
    this.width,
    this.borderRadius,
  }) : variant = variant ?? (isOutlined ? AppButtonVariant.secondary : AppButtonVariant.primary);

  const AppButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
    this.backgroundColor,
    this.textColor,
    this.height = 50.0,
    this.width,
    this.borderRadius,
  })  : variant = AppButtonVariant.primary,
        borderColor = null;

  const AppButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.height = 50.0,
    this.width,
    this.borderRadius,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.ghost({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
    this.textColor,
    this.height = 50.0,
    this.width,
    this.borderRadius,
  })  : variant = AppButtonVariant.ghost,
        backgroundColor = Colors.transparent,
        borderColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final bool isDisabled = onPressed == null || isLoading;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(14.0);

    final labelStyle = TextStyle(
      fontFamily: 'Inter',
      fontSize: 15,
      fontWeight: FontWeight.w600,
      height: 20 / 15,
      letterSpacing: -0.1,
      color: _getTextColor(colors, isDisabled),
    );

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: switch (variant) {
        AppButtonVariant.primary => _buildElevatedButton(colors: colors, isDisabled: isDisabled, radius: effectiveRadius, labelStyle: labelStyle),
        AppButtonVariant.secondary => _buildOutlinedButton(colors: colors, isDisabled: isDisabled, radius: effectiveRadius, labelStyle: labelStyle),
        AppButtonVariant.ghost => _buildGhostButton(colors: colors, isDisabled: isDisabled, radius: effectiveRadius, labelStyle: labelStyle),
      },
    );
  }

  Widget _buildElevatedButton({
    required ColorScheme colors,
    required bool isDisabled,
    required BorderRadius radius,
    required TextStyle labelStyle,
  }) {
    final bg = backgroundColor ?? colors.secondary; // #369D88
    final fg = textColor ?? colors.onSecondary;

    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        disabledBackgroundColor: bg.withValues(alpha: 0.4),
        disabledForegroundColor: fg.withValues(alpha: 0.7),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: radius),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: _buildChild(progressColor: fg, labelStyle: labelStyle),
    );
  }

  Widget _buildOutlinedButton({
    required ColorScheme colors,
    required bool isDisabled,
    required BorderRadius radius,
    required TextStyle labelStyle,
  }) {
    final effectiveBorderColor = isDisabled ? colors.outlineVariant : (borderColor ?? colors.outlineVariant);

    return OutlinedButton(
      onPressed: isDisabled ? null : onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? colors.surface,
        foregroundColor: textColor ?? colors.onSurface,
        disabledForegroundColor: colors.onSurfaceVariant,
        elevation: 0,
        side: BorderSide(color: effectiveBorderColor, width: 1.0),
        shape: RoundedRectangleBorder(borderRadius: radius),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: _buildChild(progressColor: colors.primary, labelStyle: labelStyle),
    );
  }

  Widget _buildGhostButton({
    required ColorScheme colors,
    required bool isDisabled,
    required BorderRadius radius,
    required TextStyle labelStyle,
  }) {
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? colors.primary,
        disabledForegroundColor: colors.onSurfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: radius),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: _buildChild(progressColor: colors.primary, labelStyle: labelStyle),
    );
  }

  Widget _buildChild({required Color progressColor, required TextStyle labelStyle}) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.2,
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        ),
      );
    }

    if (leadingIcon == null && trailingIcon == null) {
      return Text(text, style: labelStyle);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          IconTheme(
            data: IconThemeData(size: 18, color: labelStyle.color),
            child: leadingIcon!,
          ),
          const SizedBox(width: 8),
        ],
        Text(text, style: labelStyle),
        if (trailingIcon != null) ...[
          const SizedBox(width: 8),
          IconTheme(
            data: IconThemeData(size: 18, color: labelStyle.color),
            child: trailingIcon!,
          ),
        ],
      ],
    );
  }

  Color _getTextColor(ColorScheme colors, bool isDisabled) {
    if (isDisabled) return colors.onSurfaceVariant;
    if (textColor != null) return textColor!;

    return switch (variant) {
      AppButtonVariant.primary => colors.onSecondary,
      AppButtonVariant.secondary => colors.onSurface,
      AppButtonVariant.ghost => colors.primary,
    };
  }
}