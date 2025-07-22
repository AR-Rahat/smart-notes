import 'package:flutter/material.dart';

/// Defines color palette for the application.
///
/// Consider using the color name that is mentioned in Figma.
sealed class AppColorPalette {
  const AppColorPalette._();

  static const alpha = Colors.transparent;

  static const americanOrange = Color(0xFFFF8800);
  static const black = Color(0xFF000000);
  static const blackLead = Color(0xFF202020);
  static const cantaloupe = Color(0xFFFFE600);
  static const darkGrey = Color(0xFF171717);
  static const foggyGrey = Color(0xFF363636);
  static const mutedGrey = Color(0xFF444444);
  static const graphite = Color(0xFF444444);
  static const keyLime = Color(0xFFF0E68C);
  static const lightLime = Color(0xFFF9F3C2);
  static const lightSkyBlue = Color(0xFF4C9DFF);
  static const oceanBlue = Color(0xFF6bac18);
  static const red = Color(0xFFDD2C00);
  static const silverPolish = Color(0xFFC6C6C6);
  static const royalPurple = Color(0xFF4444DA);
  static const ultraviolet = Color(0xFFB2AEF3);
  //static const white = Color(0xFFF8F8FF);
  static const whisperingBlue = Color(0xFFD4E4FC);

  static const darkBase = Color(0xFF161616);
  static const brandColorMain = Color(0xFF54A32F);
  static const brandColor30 = Color(0xFFC4D6AC);
  static const brandColor10 = Color(0xFFDBE1D4);
  static const neutral = Color(0xFFC4C4C4);
  static const background = Color(0xFFF8F8FF);
  static const error = Color(0xFFED293F);
  static const darkGreen = Color(0xFF43641A);
  static const text = Color(0xFF12111A);
  static const white = Color(0xFFFFFFFF);
  static const divider = Color(0xFFE7E7E8);
  static const greenNew = Color(0xFF0E7C41);
  static const grey500 = Color(0xFF667085);
  static const mutedBlack = Color(0xFF575660);

  static const notePrimary = Color(0xFF131A54);
  static const notePrimaryVariant = Color(0xAA131A54);
  static const noteOnPrimary = Color(0xFFFCFFF7);
  static const noteSecondary = Color(0xFF0365DA);
  static const noteSecondaryVariant = Color(0xBB0365DA);
  static const noteTertiary = Color(0xFF575660);
  static const noteTertiaryVariant = Color(0xFF575660);
  static const noteBackground = Color(0xFFF9FAFC);
  static const noteOnBackground = Color(0xFF030406);

  static const appPrimaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0XFF54A330),
      Color(0XFF298A3A),
    ],
  );

  static const appHomeGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      Color(0XFF54A330),
      Color(0XFF298A3A),
    ],
  );

  static const appDarkGreenGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      darkGreen,
      Color(0XFF298A3A),
    ],
  );

  static const whiteGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      white,
      white,
    ],
  );

  static const fabShadow = Color(0xff78B828);
}
