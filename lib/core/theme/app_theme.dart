import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark, // High-contrast dark mode
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.vibrantOrange,
        onPrimary: AppColors.black,
        primaryContainer: AppColors.vibrantOrange,
        onPrimaryContainer: AppColors.black,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onTertiary,
        tertiaryContainer: AppColors.tertiaryContainer,
        onTertiaryContainer: AppColors.onTertiaryContainer,
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: AppColors.errorContainer,
        onErrorContainer: AppColors.onErrorContainer,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.black,
        outlineVariant: AppColors.black,
        surfaceTint: AppColors.surfaceTint,
        inverseSurface: AppColors.inverseSurface,
        onInverseSurface: AppColors.inverseOnSurface,
        inversePrimary: AppColors.inversePrimary,
        scrim: Color(0xBF000000), // High opacity scrim
      ),
      scaffoldBackgroundColor: AppColors.background,
      dividerTheme: const DividerThemeData(
        color: AppColors.black,
        thickness: AppSpacing.borderThicknessMedium,
        space: 1.0,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        titleTextStyle: AppTypography.headlineLgMobile.copyWith(color: AppColors.onSurface),
        iconTheme: const IconThemeData(color: AppColors.onSurface, size: 24.0),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.vibrantOrange,
        foregroundColor: AppColors.black,
        elevation: 0.0,
        highlightElevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Sharp FAB
          side: BorderSide(color: AppColors.black, width: AppSpacing.borderThicknessMedium),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.vibrantOrange,
          foregroundColor: AppColors.black,
          disabledBackgroundColor: AppColors.surfaceBright,
          disabledForegroundColor: AppColors.grey,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Sharp corners
            side: BorderSide(color: AppColors.black, width: AppSpacing.borderThicknessMedium),
          ),
          textStyle: AppTypography.labelMd,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.paleCream, // Secondary high-contrast highlights
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Sharp corners
            side: BorderSide(color: AppColors.black, width: AppSpacing.borderThicknessMedium),
          ),
          textStyle: AppTypography.labelMd,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white, // Inputs start with white backgrounds
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        labelStyle: AppTypography.labelMd.copyWith(color: AppColors.black),
        hintStyle: AppTypography.bodySm.copyWith(color: AppColors.grey),
        errorStyle: AppTypography.caption.copyWith(color: AppColors.error),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.black, width: AppSpacing.borderThicknessMedium),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.black, width: AppSpacing.borderThicknessMedium),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.black, width: AppSpacing.borderThicknessThick),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.error, width: AppSpacing.borderThicknessMedium),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.error, width: AppSpacing.borderThicknessThick),
        ),
      ),
      cardTheme: const CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Sharp corners
          side: BorderSide(color: AppColors.black, width: AppSpacing.borderThicknessMedium),
        ),
      ),
    );
  }
}
