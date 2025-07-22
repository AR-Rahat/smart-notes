import 'package:flutter/material.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';

enum MaterialTextType {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleTinyUppercase,
  titleXLUppercase,
  titleSmallUppercase,
  titleLarge,
  titleMedium,
  titleMediumUppercase,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmallUppercase,
  bodySmall,
  labelXL,
  labelLarge,
  labelMedium,
  labelSmall,
  labelTiny,
}

class MaterialAppText extends StatelessWidget {
  factory MaterialAppText.labelTiny(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.labelTiny,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  // 🔧 FACTORY CONSTRUCTORS

  factory MaterialAppText.displayLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.displayLarge,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.displayMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.displayMedium,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.displaySmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.displaySmall,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.headlineLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.headlineLarge,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.headlineMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.headlineMedium,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.headlineSmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.headlineSmall,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.titleTinyUppercase(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text.toUpperCase(),
        key: key,
        type: MaterialTextType.titleTinyUppercase,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.titleXLUppercase(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text.toUpperCase(),
        key: key,
        type: MaterialTextType.titleXLUppercase,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.titleSmallUppercase(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text.toUpperCase(),
        key: key,
        type: MaterialTextType.titleSmallUppercase,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.titleLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.titleLarge,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.titleMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.titleMedium,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.titleMediumUppercase(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text.toUpperCase(),
        key: key,
        type: MaterialTextType.titleMediumUppercase,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.titleSmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.titleSmall,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.bodyLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.bodyLarge,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.bodyMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.bodyMedium,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.bodySmallUppercase(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text.toUpperCase(),
        key: key,
        type: MaterialTextType.bodySmallUppercase,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.bodySmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.bodySmall,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.labelXL(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.labelXL,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.labelLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.labelLarge,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.labelMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.labelMedium,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.labelSmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) =>
      MaterialAppText._(
        text,
        key: key,
        type: MaterialTextType.labelSmall,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        fontSize: fontSize,
        enableAutoTextSize: enableAutoTextSize,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  factory MaterialAppText.custom(
    String text, {
    required TextStyle baseStyle,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    String? fontFamily,
    double? lineHeight,
    FontWeight? fontWeight,
    double? fontSize,
    bool enableAutoTextSize = false,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness = 1.0,
  }) {
    final modifiedStyle = baseStyle.copyWith(
      color: color,
      letterSpacing: letterSpacing,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      height:
          lineHeight != null && fontSize != null ? lineHeight / fontSize : null,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );

    return MaterialAppText._(
      text,
      key: key,
      type: MaterialTextType.bodyMedium,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      letterSpacing: letterSpacing,
      fontFamily: fontFamily,
      lineHeight: lineHeight,
      fontWeight: fontWeight,
      fontSize: fontSize,
      enableAutoTextSize: enableAutoTextSize,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      customTextStyle: modifiedStyle,
    );
  }

  const MaterialAppText._(
    this.text, {
    required this.type,
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.fontFamily,
    this.lineHeight,
    this.fontWeight,
    this.fontSize,
    this.enableAutoTextSize = false,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness = 1.0,
    this.customTextStyle,
  });

  final String text;
  final MaterialTextType type;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final String? fontFamily;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool enableAutoTextSize;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final TextStyle? customTextStyle;

  @override
  Widget build(BuildContext context) {
    final styles = context.appMaterialTextStyles;

    final style = switch (type) {
      MaterialTextType.displayLarge => styles.displayLarge.copyWith(
        fontSize: _scalableTextSize(57, context),
      ),
      MaterialTextType.displayMedium => styles.displayMedium.copyWith(
        fontSize: _scalableTextSize(45, context),
      ),
      MaterialTextType.displaySmall => styles.displaySmall.copyWith(
        fontSize: _scalableTextSize(36, context),
      ),
      MaterialTextType.headlineLarge => styles.headlineLarge.copyWith(
        fontSize: _scalableTextSize(32, context),
      ),
      MaterialTextType.headlineMedium => styles.headlineMedium.copyWith(
        fontSize: _scalableTextSize(26, context),
      ),
      MaterialTextType.headlineSmall => styles.headlineSmall.copyWith(
        fontSize: _scalableTextSize(23, context),
      ),
      MaterialTextType.titleTinyUppercase => styles.titleTinyUppercase.copyWith(
        fontSize: _scalableTextSize(12, context),
      ),
      MaterialTextType.titleXLUppercase => styles.tittleXLUppercase.copyWith(
        fontSize: _scalableTextSize(16, context),
      ),
      MaterialTextType.titleSmallUppercase => styles.titleSmallUppercase.copyWith(
        fontSize: _scalableTextSize(14, context),
      ),
      MaterialTextType.titleLarge => styles.titleLarge.copyWith(
        fontSize: _scalableTextSize(20, context),
      ),
      MaterialTextType.titleMedium => styles.titleMedium.copyWith(
        fontSize: _scalableTextSize(16, context),
      ),
      MaterialTextType.titleMediumUppercase => styles.titleMediumUppercase.copyWith(
        fontSize: _scalableTextSize(16, context),
      ),
      MaterialTextType.titleSmall => styles.titleSmall.copyWith(
        fontSize: _scalableTextSize(14, context),
      ),
      MaterialTextType.bodyLarge => styles.bodyLarge.copyWith(
        fontSize: _scalableTextSize(16, context),
      ),
      MaterialTextType.bodyMedium => styles.bodyMedium.copyWith(
        fontSize: _scalableTextSize(14, context),
      ),
      MaterialTextType.bodySmallUppercase => styles.bodySmallUppercase.copyWith(
        fontSize: _scalableTextSize(14, context),
      ),
      MaterialTextType.bodySmall => styles.bodySmall.copyWith(
        fontSize: _scalableTextSize(12, context),
      ),
      MaterialTextType.labelXL => styles.labelXL.copyWith(
        fontSize: _scalableTextSize(16, context),
      ),
      MaterialTextType.labelLarge => styles.labelLarge.copyWith(
        fontSize: _scalableTextSize(14, context),
      ),
      MaterialTextType.labelMedium => styles.labelMedium.copyWith(
        fontSize: _scalableTextSize(12, context),
      ),
      MaterialTextType.labelSmall => styles.labelSmall.copyWith(
        fontSize: _scalableTextSize(11, context),
      ),
      MaterialTextType.labelTiny => styles.labelTiny.copyWith(
        fontSize: _scalableTextSize(11, context),
      ),
    };

    TextStyle? customStyle = style.copyWith(
      color: color,
      letterSpacing: letterSpacing,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: _scalableTextSize(fontSize, context),
      height: lineHeight != null && fontSize != null
          ? lineHeight! / fontSize!
          : null,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle ?? TextDecorationStyle.solid,
      decorationThickness: decorationThickness,
    );

    if (customTextStyle != null) {
      customStyle = customTextStyle;
    }

    return Text(
      text,
      style: customStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  double? _scalableTextSize(double? size, BuildContext context){
    if(size == null) return null;

    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    final devicePixelRatio = mediaQueryData.devicePixelRatio;
    final aspectRatio = screenWidth / screenHeight;
    const designWidth = 390;
    const designHeight = 850;

    final scaleW = size * screenWidth / designWidth;
    final scaleH = size * screenHeight / designHeight;
    final densityBoost = devicePixelRatio * aspectRatio;

    return (scaleW + scaleH + densityBoost) / 2.4;
  }

}
