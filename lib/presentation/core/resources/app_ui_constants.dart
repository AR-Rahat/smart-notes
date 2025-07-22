import 'package:flutter/material.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';

/// Represents a collection of constants specific to the app's user interface (UI).
///
/// This class contains non-sensitive information and is designed to maintain consistency
/// across the app's UI elements.
sealed class AppUiConstants {
  AppUiConstants._();

  // Animations
  static const animationDuration = Duration(milliseconds: 250);

  // Curves
  static const transitionCurve = Curves.fastEaseInToSlowEaseOut;

  // Paddings
  static const defaultScreenHorizontalPadding =
      EdgeInsets.only(left: 16.0, right:16.0,bottom: 24);

  static const defaultTextFieldHorizontalPadding =
  EdgeInsets.symmetric(horizontal: 2);

  static const defaultTextFieldInputHorizontalPadding =
  EdgeInsets.symmetric(horizontal: 6);

  static const defaultSmallButtonContentPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 8.0,
  );

  static const defaultButtonContentPadding = EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 18.0,
  );

  // Text styles
  static const defaultSmallButtonTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const defaultButtonTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  // Border radius
  /// Assign border radius value if you want to have radius on buttons, textfields, etc.
  /// Don't assign any value if you want to have the default full rounded radius (Stadium border).
  /// Example —
  /// ```dart
  /// static double? defaultBorderRadius;
  /// ````
  static double? defaultBorderRadius = 12.0;

  static double defaultCardBorderRadius = 8.0;
}
extension AllSizeBoxes on BuildContext {
  SizedBox get smallVerticalGap => SizedBox(height: h8);
  SizedBox get mediumVerticalGap => SizedBox(height: h16);
  SizedBox get largeVerticalGap => SizedBox(height: h24);
  SizedBox customVerticalGap(double gap) => SizedBox(height: gap);

  SizedBox get smallHorizontalGap => SizedBox(width: w4);
  SizedBox get mediumHorizontalGap => SizedBox(width: w8);
  SizedBox get largeHorizontalGap => SizedBox(width: w16);
  SizedBox customHorizontalGap(double gap) => SizedBox(width: gap);
}
