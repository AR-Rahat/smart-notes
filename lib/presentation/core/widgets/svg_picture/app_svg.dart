import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_notes/presentation/core/widgets/svg_picture/svg_color_mapper.dart';

enum AppSvgType {
  noChange,
  toggleAble,
  partChange,
}

class AppSvg extends StatelessWidget {
  const AppSvg._(
    this.assetPath, {
    required this.type,
    super.key,
    this.fromColor,
    this.toColor,
    this.height,
    this.width,
  });

  factory AppSvg.fixedColor(
    String assetPath, {
    Key? key,
    Color? color,
    double? height,
    double? width,
  }) {
    return AppSvg._(
      assetPath,
      key: key,
      toColor: color,
      type: AppSvgType.noChange,
      height: height,
      width: width,
    );
  }

  factory AppSvg.toggleAbleColor(
    String assetPath, {
    required Color activeColor,
    required Color inactiveColor,
    required bool isActive,
    Key? key,
    double? height,
    double? width,
  }) {
    return AppSvg._(
      assetPath,
      key: key,
      toColor: isActive ? activeColor : inactiveColor,
      type: AppSvgType.toggleAble,
      height: height,
      width: width,
    );
  }

  factory AppSvg.partialColorMapped(
    String assetPath, {
    required Color fromColor,
    required Color toColor,
    Key? key,
    double? height,
    double? width,
  }) {
    return AppSvg._(
      assetPath,
      key: key,
      fromColor: fromColor,
      toColor: toColor,
      type: AppSvgType.partChange,
      height: height,
      width: width,
    );
  }

  final String assetPath;
  final AppSvgType type;
  final Color? fromColor;
  final Color? toColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final ColorMapper? colorMapper = switch (type) {
      AppSvgType.noChange => toColor != null
          ? SvgColorMapper(toColor: toColor ?? Colors.black)
          : null,
      AppSvgType.toggleAble =>
        SvgColorMapper(toColor: toColor ?? Colors.black),
      AppSvgType.partChange =>
        SvgColorMapper(toColor: toColor ?? Colors.black, fromColor: fromColor),
    };

    return SizedBox(
      height: height,
      width: width,
      child: SvgPicture(
        height: height,
        width: width,
        fit: BoxFit.cover,
        SvgAssetLoader(
          assetPath,
          colorMapper: colorMapper,
        ),
      ),
    );
  }
}
