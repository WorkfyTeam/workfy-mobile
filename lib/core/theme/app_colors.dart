import 'package:flutter/material.dart';

abstract final class AppColors {
  // 1. Core Brand Palette (6 Essential Colors)
  static const Color darkGreen = Color(0xFF033335);       // Splash & Dark Surface
  static const Color primary = Color(0xFF1EAB8B);         // Brand Accent & Active Highlights
  static const Color primaryButton = Color(0xFF369D88);   // Primary Buttons (Log In)
  static const Color white = Color(0xFFFFFFFF);           // Light Background & OnPrimary
  static const Color darkText = Color(0xFF0D2C26);        // Light Primary Text & Input Text
  static const Color inputBackground = Color(0xFFF5F7F4); // Input Fields & Subtle Surfaces

  // 2. Derived Light Theme Tokens
  static const Color lightBackground = white;
  static const Color lightSurface = white;
  static const Color lightSurfaceContainer = inputBackground;
  static const Color lightSurfaceHighest = Color(0xFFE7EDE9);

  static const Color lightTextPrimary = darkText;
  static const Color lightTextSecondary = Color(0xFF4A635D);
  static const Color lightTextMuted = Color(0xFF8A9E99);

  static const Color lightBorder = Color(0xFFE2E8E5);
  static const Color lightPrimaryContainer = Color(0xFFE6F7F3);

  // 3. Derived Dark Theme Tokens (Based on #033335)
  static const Color darkBackground = Color(0xFF022224);
  static const Color darkSurface = darkGreen;
  static const Color darkSurfaceLow = Color(0xFF022A2C);
  static const Color darkSurfaceHigh = Color(0xFF074346);
  static const Color darkSurfaceHighest = Color(0xFF0D5458);

  static const Color darkTextPrimary = white;
  static const Color darkTextSecondary = Color(0xFFA3C2BC);
  static const Color darkTextMuted = Color(0xFF6B8F88);

  static const Color darkBorder = Color(0xFF0D5458);
  static const Color darkPrimaryContainer = Color(0xFF0D5458);
  static const Color darkOnPrimaryContainer = Color(0xFFD1F5EC);

  // 4. Minimal Semantic Status Tokens
  static const Color success = primary;
  static const Color lightSuccessBackground = lightPrimaryContainer;
  static const Color lightSuccessText = darkGreen;
  static const Color darkSuccessBackground = darkSurfaceHigh;
  static const Color darkSuccessText = Color(0xFF6EE7C8);

  static const Color warning = Color(0xFFD97706);
  static const Color lightWarningBackground = Color(0xFFFFF7ED);
  static const Color lightWarningText = Color(0xFF92400E);
  static const Color lightWarningBorder = Color(0xFFFDE68A);
  static const Color darkWarningBackground = Color(0xFF422006);
  static const Color darkWarningText = Color(0xFFFCD34D);
  static const Color darkWarningBorder = Color(0xFF854D0E);

  static const Color danger = Color(0xFFDC2626);
  static const Color lightDangerBackground = Color(0xFFFEF2F2);
  static const Color lightDangerText = Color(0xFFB91C1C);
  static const Color darkDangerBackground = Color(0xFF450A0A);
  static const Color darkDangerText = Color(0xFFFCA5A5);
}