import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';

sealed class AppTheme {
  const AppTheme._();

  static ThemeData fromBrightness(Brightness brightness) {
    final _appColors = AppColors.fromBrightness(brightness);
    final _appTextStyles = AppTextStyles.fromBrightness(brightness);
    final _materialTextStyles = MaterialTextStyles.fromBrightness(brightness);

    final _lightColorScheme = ColorScheme.light(
      brightness: brightness,
      primary: _appColors.primary,
      onPrimary: _appColors.foregroundOnPrimary,
      surface: _appColors.background,
      secondary: _appColors.secondary,
      onSecondary: _appColors.foregroundOnSecondary,
      onSurface: _appColors.foregroundOnBackground,
      outline: _appColors.outline,
      error: _appColors.danger,
      onError: _appColors.foregroundOnDanger,
    );

    final _darkColorScheme = ColorScheme.dark(
      brightness: brightness,
      primary: _appColors.primary,
      onPrimary: _appColors.foregroundOnPrimary,
      secondary: _appColors.secondary,
      onSecondary: _appColors.foregroundOnSecondary,
      surface: _appColors.background,
      onSurface: _appColors.foregroundOnBackground,
      outline: _appColors.outline,
      error: _appColors.danger,
      onError: _appColors.foregroundOnDanger,
    );

    final _appColorScheme = switch (brightness) {
      Brightness.light => _lightColorScheme,
      Brightness.dark => _darkColorScheme,
    };

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: _appColors.background,
      splashFactory: InkRipple.splashFactory,
      fontFamily: AppFonts.activeFontFamily,
      colorScheme: _appColorScheme,
      highlightColor: Colors.transparent,
      splashColor: _appColors.splashColor,
      disabledColor: _appColors.disabledColor,
      dividerColor: _appColors.dividerColor,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        color: _appColors.background,
        foregroundColor: _appColors.foregroundOnBackground,
      ),
      dividerTheme: DividerThemeData(
        color: _appColors.dividerColor,
      ),
      extensions: [
        _appColors,
        _appTextStyles,
        _materialTextStyles
      ],
    );
  }
}
