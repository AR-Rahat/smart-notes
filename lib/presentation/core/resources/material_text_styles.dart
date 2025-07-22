import 'package:flutter/material.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'material_text_styles.tailor.dart';

@TailorMixin()
class MaterialTextStyles extends ThemeExtension<MaterialTextStyles>
    with _$MaterialTextStylesTailorMixin {
  MaterialTextStyles({
    required this.bodySmall,
    required this.bodyLarge,
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleTinyUppercase,
    required this.tittleXLUppercase,
    required this.titleSmallUppercase,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleMediumUppercase,
    required this.titleSmall,
    required this.bodyMedium,
    required this.bodySmallUppercase,
    required this.labelXL,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.labelTiny,
  });

  factory MaterialTextStyles.fromBrightness(Brightness brightness) {
    final appColors = AppColors.fromBrightness(brightness);

    final fontFamily = AppFonts.activeFontFamily;

    return MaterialTextStyles(
      displayLarge: TextStyle(
        fontSize: 57,
        height: 64 / 57,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        height: 52 / 45,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        height: 48 / 36,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        height: 40 / 32,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      headlineMedium: TextStyle(
        fontSize: 26,
        height: 34 / 26,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      headlineSmall: TextStyle(
        fontSize: 23,
        height: 24 / 23,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      titleTinyUppercase: TextStyle(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        letterSpacing: 1,
        color: appColors.foregroundOnBackground,
      ),
      tittleXLUppercase: TextStyle(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
        letterSpacing: 1,
        color: appColors.foregroundOnBackground,
      ),
      titleSmallUppercase: TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        letterSpacing: 0.75,
        color: appColors.foregroundOnBackground,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        height: 24 / 20,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        height: 16 / 16,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      titleMediumUppercase: TextStyle(
        fontSize: 16,
        height: 16 / 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      bodySmallUppercase: TextStyle(
        fontSize: 14,
        height: 16 / 14,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      labelXL: TextStyle(
        fontSize: 16,
        height: 20 / 16,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      labelSmall: TextStyle(
        fontSize: 11, // height as per image (Auto fallback)
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
      labelTiny: TextStyle(
        fontSize: 11,
        height: 1,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: appColors.foregroundOnBackground,
      ),
    );
  }

  @override
  final TextStyle displayLarge;
  @override
  final TextStyle displayMedium;
  @override
  final TextStyle displaySmall;
  @override
  final TextStyle headlineLarge;
  @override
  final TextStyle headlineMedium;
  @override
  final TextStyle headlineSmall;
  @override
  final TextStyle titleTinyUppercase;
  @override
  final TextStyle tittleXLUppercase;
  @override
  final TextStyle titleSmallUppercase;
  @override
  final TextStyle titleLarge;
  @override
  final TextStyle titleMedium;
  @override
  final TextStyle titleMediumUppercase;
  @override
  final TextStyle titleSmall;
  @override
  final TextStyle bodyLarge;
  @override
  final TextStyle bodyMedium;
  @override
  final TextStyle bodySmallUppercase;
  @override
  final TextStyle bodySmall;
  @override
  final TextStyle labelXL;
  @override
  final TextStyle labelLarge;
  @override
  final TextStyle labelMedium;
  @override
  final TextStyle labelSmall;
  @override
  final TextStyle labelTiny;
}

extension MaterialTextStylesExtension on BuildContext {
  MaterialTextStyles get appMaterialTextStyles {
    final materialTextStyles = Theme.of(this).extension<MaterialTextStyles>();

    if (materialTextStyles == null) {
      throw Exception(
        'Could not find the ThemeData extension for text styles.\n Make sure'
            ' to pass AppTextStyles as ThemeData extension.',
      );
    }
    return materialTextStyles;
  }
}
