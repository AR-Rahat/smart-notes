import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class DashedRect extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double? cornerRadius; // Optional corner radius
  final Widget? child;

  const DashedRect({
    super.key,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
    this.cornerRadius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(strokeWidth / 2),
      child: CustomPaint(
        painter: DashRectPainter(
          color: color,
          strokeWidth: strokeWidth,
          gap: gap,
          cornerRadius: cornerRadius,
        ),
        child: child,
      ),
    );
  }
}

class DashRectPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double gap;
  final double? cornerRadius; // Optional corner radius

  DashRectPainter({
    this.strokeWidth = 5.0,
    this.color = Colors.red,
    this.gap = 5.0,
    this.cornerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    if (cornerRadius != null && cornerRadius! > 0) {
      // Create a rounded rectangle with dashed borders
      final Path roundedRectPath = createDashedRoundedRectPath(
        Rect.fromLTWH(0, 0, size.width, size.height),
        cornerRadius!,
        gap,
      );
      canvas.drawPath(roundedRectPath, dashedPaint);
    } else {
      // Draw regular dashed rectangle
      final double x = size.width;
      final double y = size.height;

      final Path topPath = getDashedPath(
        a: const math.Point(0, 0),
        b: math.Point(x, 0),
        gap: gap,
      );

      final Path rightPath = getDashedPath(
        a: math.Point(x, 0),
        b: math.Point(x, y),
        gap: gap,
      );

      final Path bottomPath = getDashedPath(
        a: math.Point(0, y),
        b: math.Point(x, y),
        gap: gap,
      );

      final Path leftPath = getDashedPath(
        a: const math.Point(0, 0),
        b: math.Point(0.001, y),
        gap: gap,
      );

      canvas.drawPath(topPath, dashedPaint);
      canvas.drawPath(rightPath, dashedPaint);
      canvas.drawPath(bottomPath, dashedPaint);
      canvas.drawPath(leftPath, dashedPaint);
    }
  }

  Path createDashedRoundedRectPath(Rect rect, double radius, double gap) {
    final Path path = Path();
    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final Path originalPath = Path()..addRRect(rrect);

    final PathMetrics pathMetrics = originalPath.computeMetrics();
    for (final PathMetric metric in pathMetrics) {
      double distance = 0.0;
      bool draw = true;

      while (distance < metric.length) {
        final Tangent? tangent = metric.getTangentForOffset(distance);
        if (tangent != null) {
          if (draw) {
            path.moveTo(tangent.position.dx, tangent.position.dy);
          } else {
            path.lineTo(tangent.position.dx, tangent.position.dy);
          }
        }
        distance += gap;
        draw = !draw;
      }
    }
    return path;
  }

  Path getDashedPath({
    required math.Point<double> a,
    required math.Point<double> b,
    required double gap,
  }) {
    final Size size = Size(b.x - a.x, b.y - a.y);
    final Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    math.Point currentPoint = math.Point(a.x, a.y);

    final num radians = math.atan(size.height / size.width);
    final num dx = math.cos(radians).abs() * gap;
    final num dy = math.sin(radians).abs() * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      if (shouldDraw) {
        path.lineTo(currentPoint.x as double, currentPoint.y as double);
      } else {
        path.moveTo(currentPoint.x as double, currentPoint.y as double);
      }
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
