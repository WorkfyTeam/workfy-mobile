import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'theme_extension.dart';

class AppTheme {
  AppTheme._();

  static const String _fontFamily = 'Inter';

  static final ThemeData lightTheme = _buildTheme(
    brightness: Brightness.light,
    scheme: _lightScheme,
    palette: WorkBridgeThemeExtension.light,
  );

  static final ThemeData darkTheme = _buildTheme(
    brightness: Brightness.dark,
    scheme: _darkScheme,
    palette: WorkBridgeThemeExtension.dark,
  );

  static const ColorScheme _lightScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.lightPrimaryContainer,
    onPrimaryContainer: AppColors.darkGreen,
    secondary: AppColors.primaryButton,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.lightPrimaryContainer,
    onSecondaryContainer: AppColors.darkGreen,
    tertiary: AppColors.primary,
    onTertiary: AppColors.white,
    tertiaryContainer: AppColors.lightPrimaryContainer,
    onTertiaryContainer: AppColors.darkGreen,
    error: AppColors.danger,
    onError: AppColors.white,
    errorContainer: AppColors.lightDangerBackground,
    onErrorContainer: AppColors.lightDangerText,
    surface: AppColors.lightSurface,
    onSurface: AppColors.lightTextPrimary,
    onSurfaceVariant: AppColors.lightTextSecondary,
    outline: AppColors.lightTextMuted,
    outlineVariant: AppColors.lightBorder,
    surfaceContainerLowest: AppColors.white,
    surfaceContainerLow: AppColors.inputBackground,
    surfaceContainer: AppColors.inputBackground,
    surfaceContainerHigh: AppColors.lightSurfaceHighest,
    surfaceContainerHighest: AppColors.lightSurfaceHighest,
  );

  static const ColorScheme _darkScheme = ColorScheme.dark(
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.darkPrimaryContainer,
    onPrimaryContainer: AppColors.darkOnPrimaryContainer,
    secondary: AppColors.primaryButton,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.darkSurfaceHigh,
    onSecondaryContainer: AppColors.darkOnPrimaryContainer,
    tertiary: AppColors.primary,
    onTertiary: AppColors.white,
    tertiaryContainer: AppColors.darkSurfaceHigh,
    onTertiaryContainer: AppColors.darkOnPrimaryContainer,
    error: Color(0xFFF87171),
    onError: AppColors.darkDangerBackground,
    errorContainer: AppColors.darkDangerBackground,
    onErrorContainer: AppColors.darkDangerText,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkTextPrimary,
    onSurfaceVariant: AppColors.darkTextSecondary,
    outline: AppColors.darkTextMuted,
    outlineVariant: AppColors.darkBorder,
    surfaceContainerLowest: AppColors.darkBackground,
    surfaceContainerLow: AppColors.darkSurfaceLow,
    surfaceContainer: AppColors.darkSurface,
    surfaceContainerHigh: AppColors.darkSurfaceHigh,
    surfaceContainerHighest: AppColors.darkSurfaceHighest,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required ColorScheme scheme,
    required WorkBridgeThemeExtension palette,
  }) {
    final isDark = brightness == Brightness.dark;
    final textPrimary = scheme.onSurface;
    final textSecondary = scheme.onSurfaceVariant;
    final borderColor = scheme.outlineVariant;
    final surfaceColor = scheme.surface;

    OutlineInputBorder inputBorder(Color color, {double width = 1}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: _fontFamily,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      primaryColor: AppColors.primary,
      extensions: <ThemeExtension<dynamic>>[palette],

      textTheme: TextTheme(
        headlineLarge: TextStyle(fontFamily: _fontFamily, fontSize: 28, fontWeight: FontWeight.w700, height: 36 / 28, letterSpacing: -0.56, color: textPrimary),
        headlineMedium: TextStyle(fontFamily: _fontFamily, fontSize: 22, fontWeight: FontWeight.w700, height: 28 / 22, letterSpacing: -0.33, color: textPrimary),
        headlineSmall: TextStyle(fontFamily: _fontFamily, fontSize: 20, fontWeight: FontWeight.w700, height: 26 / 20, letterSpacing: -0.20, color: textPrimary),
        titleLarge: TextStyle(fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w700, color: textPrimary),
        titleMedium: TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w600, height: 22 / 16, letterSpacing: -0.16, color: textPrimary),
        titleSmall: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w600, height: 20 / 14, color: textPrimary),
        bodyLarge: TextStyle(fontFamily: _fontFamily, fontSize: 15, fontWeight: FontWeight.w500, height: 22 / 15, color: textPrimary),
        bodyMedium: TextStyle(fontFamily: _fontFamily, fontSize: 13, fontWeight: FontWeight.w400, height: 18 / 13, color: textSecondary),
        bodySmall: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w400, height: 16 / 12, color: textSecondary),
        labelLarge: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w600, height: 18 / 14, color: textPrimary),
        labelMedium: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500, height: 16 / 12, color: textSecondary),
        labelSmall: TextStyle(fontFamily: _fontFamily, fontSize: 11, fontWeight: FontWeight.w500, height: 14 / 11, color: textSecondary),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(color: textPrimary, size: 20),
        titleTextStyle: TextStyle(fontFamily: _fontFamily, color: textPrimary, fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: -0.18),
        shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
      ),

      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor, width: 1),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryButton,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.primaryButton.withValues(alpha: 0.4),
          disabledForegroundColor: AppColors.white.withValues(alpha: 0.7),
          minimumSize: const Size.fromHeight(50),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontFamily: _fontFamily, fontSize: 15, fontWeight: FontWeight.w600, height: 20 / 15),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: surfaceColor,
          foregroundColor: textPrimary,
          disabledForegroundColor: textSecondary,
          minimumSize: const Size.fromHeight(50),
          elevation: 0,
          side: BorderSide(color: borderColor, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontFamily: _fontFamily, fontSize: 15, fontWeight: FontWeight.w600, height: 20 / 15),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(fontFamily: _fontFamily, fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.darkSurfaceHigh : AppColors.inputBackground,
        hintStyle: TextStyle(fontFamily: _fontFamily, color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        border: inputBorder(borderColor),
        enabledBorder: inputBorder(borderColor),
        focusedBorder: inputBorder(AppColors.primary, width: 1.5),
        errorBorder: inputBorder(scheme.error),
        focusedErrorBorder: inputBorder(scheme.error, width: 1.5),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: palette.tagBackground,
        selectedColor: palette.activeFilterBackground,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        elevation: 0,
        pressElevation: 0,
        shape: StadiumBorder(side: BorderSide(color: borderColor, width: 1)),
        labelStyle: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500, color: palette.tagForeground),
        secondaryLabelStyle: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w600, color: scheme.primary),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        elevation: 0,
        selectedItemColor: scheme.primary,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontFamily: _fontFamily, fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontFamily: _fontFamily, fontSize: 11, fontWeight: FontWeight.w500),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceColor,
        indicatorColor: scheme.primaryContainer,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStatePropertyAll(TextStyle(fontFamily: _fontFamily, fontSize: 11, color: textPrimary)),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceColor,
        modalBackgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        elevation: 12,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        clipBehavior: Clip.antiAlias,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w700, color: textPrimary),
        contentTextStyle: TextStyle(fontFamily: _fontFamily, fontSize: 14, color: textSecondary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      dividerTheme: DividerThemeData(color: borderColor, thickness: 1, space: 1),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return scheme.onPrimary;
          return scheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return scheme.primary;
          return scheme.surfaceContainerHighest;
        }),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.surfaceContainerHighest,
        circularTrackColor: scheme.surfaceContainerHighest,
      ),
    );
  }
}