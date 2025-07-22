import 'package:flutter/material.dart';

extension ResponsiveDimensions on BuildContext {
  // === Widths ===
  double get w2 => MediaQuery.sizeOf(this).width * 0.0051;
  double get w4 => MediaQuery.sizeOf(this).width * 0.0103;
  double get w6 => MediaQuery.sizeOf(this).width * 0.0154;
  double get w8 => MediaQuery.sizeOf(this).width * 0.0205;
  double get w12 => MediaQuery.sizeOf(this).width * 0.0308;
  double get w16 => MediaQuery.sizeOf(this).width * 0.0410;
  double get w20 => MediaQuery.sizeOf(this).width * 0.0513;
  double get w24 => MediaQuery.sizeOf(this).width * 0.0615;
  double get w32 => MediaQuery.sizeOf(this).width * 0.0821;
  double get w36 => MediaQuery.sizeOf(this).width * 0.0923;
  double get w40 => MediaQuery.sizeOf(this).width * 0.1026;
  double get w48 => MediaQuery.sizeOf(this).width * 0.1231;
  double get w64 => MediaQuery.sizeOf(this).width * 0.1641;
  double get w86 => MediaQuery.sizeOf(this).width * 0.2205;

  // === Heights ===
  double get h2 => MediaQuery.sizeOf(this).height * 0.0024;
  double get h4 => MediaQuery.sizeOf(this).height * 0.0047;
  double get h8 => MediaQuery.sizeOf(this).height * 0.0094;
  double get h12 => MediaQuery.sizeOf(this).height * 0.0141;
  double get h16 => MediaQuery.sizeOf(this).height * 0.0188;
  double get h20 => MediaQuery.sizeOf(this).height * 0.0235;
  double get h24 => MediaQuery.sizeOf(this).height * 0.0282;
  double get h32 => MediaQuery.sizeOf(this).height * 0.0376;
  double get h36 => MediaQuery.sizeOf(this).height * 0.0423;
  double get h40 => MediaQuery.sizeOf(this).height * 0.0470;
  double get h48 => MediaQuery.sizeOf(this).height * 0.0565;
  double get h64 => MediaQuery.sizeOf(this).height * 0.0753;
  double get h72 => MediaQuery.sizeOf(this).height * 0.0847;

  // === Common Width Percentiles ===
  double get w5p => MediaQuery.sizeOf(this).width * 0.05;
  double get w10p => MediaQuery.sizeOf(this).width * 0.10;
  double get w25p => MediaQuery.sizeOf(this).width * 0.25;
  double get w33p => MediaQuery.sizeOf(this).width * 0.33;
  double get w50p => MediaQuery.sizeOf(this).width * 0.50;
  double get w66p => MediaQuery.sizeOf(this).width * 0.66;
  double get w75p => MediaQuery.sizeOf(this).width * 0.75;
  double get w90p => MediaQuery.sizeOf(this).width * 0.90;
  double get w100p => MediaQuery.sizeOf(this).width;

  // === Common Height Percentiles ===
  double get h5p => MediaQuery.sizeOf(this).height * 0.05;
  double get h10p => MediaQuery.sizeOf(this).height * 0.10;
  double get h25p => MediaQuery.sizeOf(this).height * 0.25;
  double get h33p => MediaQuery.sizeOf(this).height * 0.33;
  double get h50p => MediaQuery.sizeOf(this).height * 0.50;
  double get h66p => MediaQuery.sizeOf(this).height * 0.66;
  double get h75p => MediaQuery.sizeOf(this).height * 0.75;
  double get h90p => MediaQuery.sizeOf(this).height * 0.90;
  double get h100p => MediaQuery.sizeOf(this).height;

  // === Circle Radius based on width/height ===
  double get r12 => w12 / 2;
  double get r24 => w24 / 2;
  double get r32 => w32 / 2;
  double get r48 => w48 / 2;
  double get r64 => w64 / 2;

  double customHeight(double value) {
    if(value >= 850) return MediaQuery.sizeOf(this).height;
    final ratio = value / 850;
    return MediaQuery.sizeOf(this).height * ratio;
  }

  double customWidth(double value) {
    if(value >= 390) return MediaQuery.sizeOf(this).width;
    final ratio = value / 390;
    return MediaQuery.sizeOf(this).width * ratio;
  }
}
