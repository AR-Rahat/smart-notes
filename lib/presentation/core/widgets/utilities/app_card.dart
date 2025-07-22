import 'package:flutter/material.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    super.key,
    this.type = MaterialType.card,
    this.elevation = 0.0,
    this.borderRadius,
    this.shadowColor = const Color(0x271E3121),
  });

  final Widget child;
  final MaterialType type;
  final double elevation;
  final double? borderRadius;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: type,
      elevation: elevation,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius ?? context.w12 + 2),
      shadowColor: shadowColor,
      child: child,
    );
  }
}
