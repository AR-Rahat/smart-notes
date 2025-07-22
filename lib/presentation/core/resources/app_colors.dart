import 'package:flutter/material.dart';
import 'package:smart_notes/presentation/core/resources/app_color_palette.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_colors.tailor.dart';

@TailorMixin()
class AppColors extends ThemeExtension<AppColors> with _$AppColorsTailorMixin {
  static Color get black => AppColorPalette.black;

  static Color get white => AppColorPalette.white;

  const AppColors({
    required this.primary,
    required this.primaryVariant,
    required this.secondary,
    required this.secondaryVariant,
    required this.background,
    required this.appBarBackground,
    required this.danger,
    required this.foregroundOnBackground,
    required this.foregroundLightOnBackground,
    required this.foregroundOnPrimary,
    required this.foregroundOnSecondary,
    required this.foregroundOnAppBar,
    required this.foregroundOnDanger,
    required this.outline,
    required this.splashColor,
    required this.disabledColor,
    required this.transparent,
    required this.dividerColor,
    required this.neutral,
  });

  // Core colors
  @override
  final Color primary;
  @override
  final Color primaryVariant;
  @override
  final Color secondary;
  @override
  final Color secondaryVariant;
  @override
  final Color background;
  @override
  final Color appBarBackground;
  @override
  final Color danger;
  @override
  final Color foregroundOnBackground;
  @override
  final Color foregroundLightOnBackground;
  @override
  final Color foregroundOnPrimary;
  @override
  final Color foregroundOnSecondary;
  @override
  final Color foregroundOnAppBar;
  @override
  final Color foregroundOnDanger;
  @override
  final Color outline;
  @override
  final Color transparent;

  // Other colors
  @override
  final Color splashColor;
  @override
  final Color disabledColor;
  @override
  final Color dividerColor;

  @override
  final Color neutral;

  factory AppColors.fromBrightness(Brightness brightness) =>
      switch (brightness) {
        Brightness.light => AppColors.light(),
        Brightness.dark => AppColors.dark(),
      };

  factory AppColors.light() {
    return const AppColors(
      primary: AppColorPalette.notePrimary,
      primaryVariant: AppColorPalette.notePrimaryVariant,
      secondary: AppColorPalette.noteSecondary,
      secondaryVariant: AppColorPalette.noteSecondaryVariant,
      background: AppColorPalette.noteBackground,
      appBarBackground: AppColorPalette.noteBackground,
      danger: AppColorPalette.error,
      foregroundOnBackground: AppColorPalette.noteOnBackground,
      foregroundLightOnBackground: AppColorPalette.noteOnBackground,
      foregroundOnPrimary: AppColorPalette.noteOnPrimary,
      foregroundOnSecondary: AppColorPalette.noteOnPrimary,
      foregroundOnAppBar: AppColorPalette.noteOnBackground,
      foregroundOnDanger: AppColorPalette.noteOnPrimary,
      outline: AppColorPalette.grey500,
      transparent: AppColorPalette.alpha,
      splashColor: AppColorPalette.neutral,
      disabledColor: AppColorPalette.mutedBlack,
      dividerColor: AppColorPalette.divider,
      neutral: AppColorPalette.neutral,
    );
  }

  factory AppColors.dark() {
    return const AppColors(
      primary: AppColorPalette.americanOrange,
      primaryVariant: AppColorPalette.cantaloupe,
      secondary: AppColorPalette.keyLime,
      secondaryVariant: AppColorPalette.lightLime,
      background: AppColorPalette.blackLead,
      appBarBackground: AppColorPalette.darkGrey,
      danger: AppColorPalette.red,
      foregroundOnBackground: AppColorPalette.white,
      foregroundLightOnBackground: AppColorPalette.foggyGrey,
      foregroundOnPrimary: AppColorPalette.black,
      foregroundOnSecondary: AppColorPalette.black,
      foregroundOnAppBar: AppColorPalette.white,
      foregroundOnDanger: AppColorPalette.white,
      outline: AppColorPalette.americanOrange,
      transparent: AppColorPalette.alpha,
      splashColor: AppColorPalette.darkGrey,
      disabledColor: AppColorPalette.silverPolish,
      dividerColor: AppColorPalette.divider,
      neutral: AppColorPalette.neutral,
    );
  }
}

extension AppColorsExtension on BuildContext {
  AppColors get colors {
    final appColors = Theme.of(this).extension<AppColors>();

    if (appColors == null) {
      throw Exception(
        'Could not find the ThemeData extension for colors.\n Make sure to pass AppColors as ThemeData extension.',
      );
    }

    return appColors;
  }
}
