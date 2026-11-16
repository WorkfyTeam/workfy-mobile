import 'package:flutter/material.dart';
import 'app_colors.dart';

@immutable
class WorkBridgeThemeExtension extends ThemeExtension<WorkBridgeThemeExtension> {
  const WorkBridgeThemeExtension({
    required this.tagBackground,
    required this.tagForeground,
    required this.matchBackground,
    required this.matchForeground,
    required this.activeFilterBackground,
    required this.activeFilterBorder,
    required this.warningBackground,
    required this.warningForeground,
    required this.warningBorder,
    required this.successBackground,
    required this.successForeground,
    required this.dangerBackground,
    required this.dangerForeground,
  });

  final Color tagBackground;
  final Color tagForeground;

  final Color matchBackground;
  final Color matchForeground;

  final Color activeFilterBackground;
  final Color activeFilterBorder;

  final Color warningBackground;
  final Color warningForeground;
  final Color warningBorder;

  final Color successBackground;
  final Color successForeground;

  final Color dangerBackground;
  final Color dangerForeground;

  static const light = WorkBridgeThemeExtension(
    tagBackground: AppColors.inputBackground,
    tagForeground: AppColors.lightTextSecondary,
    matchBackground: AppColors.lightSuccessBackground,
    matchForeground: AppColors.lightSuccessText,
    activeFilterBackground: AppColors.lightPrimaryContainer,
    activeFilterBorder: AppColors.primary,
    warningBackground: AppColors.lightWarningBackground,
    warningForeground: AppColors.lightWarningText,
    warningBorder: AppColors.lightWarningBorder,
    successBackground: AppColors.lightSuccessBackground,
    successForeground: AppColors.lightSuccessText,
    dangerBackground: AppColors.lightDangerBackground,
    dangerForeground: AppColors.lightDangerText,
  );

  static const dark = WorkBridgeThemeExtension(
    tagBackground: AppColors.darkSurfaceHigh,
    tagForeground: AppColors.darkTextSecondary,
    matchBackground: AppColors.darkSuccessBackground,
    matchForeground: AppColors.darkSuccessText,
    activeFilterBackground: AppColors.darkPrimaryContainer,
    activeFilterBorder: AppColors.primary,
    warningBackground: AppColors.darkWarningBackground,
    warningForeground: AppColors.darkWarningText,
    warningBorder: AppColors.darkWarningBorder,
    successBackground: AppColors.darkSuccessBackground,
    successForeground: AppColors.darkSuccessText,
    dangerBackground: AppColors.darkDangerBackground,
    dangerForeground: AppColors.darkDangerText,
  );

  @override
  WorkBridgeThemeExtension copyWith({
    Color? tagBackground,
    Color? tagForeground,
    Color? matchBackground,
    Color? matchForeground,
    Color? activeFilterBackground,
    Color? activeFilterBorder,
    Color? warningBackground,
    Color? warningForeground,
    Color? warningBorder,
    Color? successBackground,
    Color? successForeground,
    Color? dangerBackground,
    Color? dangerForeground,
  }) {
    return WorkBridgeThemeExtension(
      tagBackground: tagBackground ?? this.tagBackground,
      tagForeground: tagForeground ?? this.tagForeground,
      matchBackground: matchBackground ?? this.matchBackground,
      matchForeground: matchForeground ?? this.matchForeground,
      activeFilterBackground: activeFilterBackground ?? this.activeFilterBackground,
      activeFilterBorder: activeFilterBorder ?? this.activeFilterBorder,
      warningBackground: warningBackground ?? this.warningBackground,
      warningForeground: warningForeground ?? this.warningForeground,
      warningBorder: warningBorder ?? this.warningBorder,
      successBackground: successBackground ?? this.successBackground,
      successForeground: successForeground ?? this.successForeground,
      dangerBackground: dangerBackground ?? this.dangerBackground,
      dangerForeground: dangerForeground ?? this.dangerForeground,
    );
  }

  @override
  WorkBridgeThemeExtension lerp(covariant WorkBridgeThemeExtension? other, double t) {
    if (other == null) return this;

    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;

    return WorkBridgeThemeExtension(
      tagBackground: mix(tagBackground, other.tagBackground),
      tagForeground: mix(tagForeground, other.tagForeground),
      matchBackground: mix(matchBackground, other.matchBackground),
      matchForeground: mix(matchForeground, other.matchForeground),
      activeFilterBackground: mix(activeFilterBackground, other.activeFilterBackground),
      activeFilterBorder: mix(activeFilterBorder, other.activeFilterBorder),
      warningBackground: mix(warningBackground, other.warningBackground),
      warningForeground: mix(warningForeground, other.warningForeground),
      warningBorder: mix(warningBorder, other.warningBorder),
      successBackground: mix(successBackground, other.successBackground),
      successForeground: mix(successForeground, other.successForeground),
      dangerBackground: mix(dangerBackground, other.dangerBackground),
      dangerForeground: mix(dangerForeground, other.dangerForeground),
    );
  }
}