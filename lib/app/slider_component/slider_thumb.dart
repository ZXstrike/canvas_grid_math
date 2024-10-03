import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/src/theme/slider_theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:math';

enum ThumbDirection {
  left,
  right,
  up,
  down,
}

class CustomSliderThumb extends SfThumbShape {
  final ThumbDirection direction;
  final int sliderValue;

  static const double triangleSize = 35.0;

  CustomSliderThumb({required this.direction, required this.sliderValue});

  @override
  Size getPreferredSize(SfSliderThemeData themeData) {
    return const Size(triangleSize, triangleSize);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required RenderBox? child,
    required SfSliderThemeData themeData,
    SfRangeValues? currentValues,
    dynamic currentValue,
    required Paint? paint,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required SfThumb? thumb,
  }) {
    final Path path = Path();

    final textPainter = TextPainter(
      text: TextSpan(
        text: sliderValue.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: textDirection,
    );

    textPainter.layout();

    final double height = (triangleSize * sqrt(3) / 2);
    Offset textOffset;

    switch (direction) {
      case ThumbDirection.left:
        path.moveTo(center.dx - height / 2, center.dy - triangleSize / 2);
        path.lineTo(center.dx + height / 2, center.dy);
        path.lineTo(center.dx - height / 2, center.dy + triangleSize / 2);
        path.close();
        textOffset = Offset(
          center.dx - height / 2 + (height - textPainter.width) / 2,
          center.dy - textPainter.height / 2,
        );
        break;
      case ThumbDirection.right:
        path.moveTo(center.dx + height / 2, center.dy - triangleSize / 2);
        path.lineTo(center.dx - height / 2, center.dy);
        path.lineTo(center.dx + height / 2, center.dy + triangleSize / 2);
        path.close();
        textOffset = Offset(
          center.dx - height / 2 + (height - textPainter.width) / 2,
          center.dy - textPainter.height / 2,
        );
        break;
      case ThumbDirection.up:
        path.moveTo(center.dx - triangleSize / 2, center.dy - height / 2);
        path.lineTo(center.dx, center.dy + height / 2);
        path.lineTo(center.dx + triangleSize / 2, center.dy - height / 2);
        path.close();
        textOffset = Offset(
          center.dx - textPainter.width / 2,
          center.dy - height / 2 + (height - textPainter.height) / 2,
        );
        break;
      case ThumbDirection.down:
        path.moveTo(center.dx - triangleSize / 2, center.dy + height / 2);
        path.lineTo(center.dx, center.dy - height / 2);
        path.lineTo(center.dx + triangleSize / 2, center.dy + height / 2);
        path.close();
        textOffset = Offset(
          center.dx - textPainter.width / 2,
          center.dy - height / 2 + (height - textPainter.height) / 2,
        );
        break;
    }

    context.canvas.drawPath(
        path,
        Paint()
          ..color = Colors.cyan
          ..style = PaintingStyle.fill
          ..strokeWidth = 2);

    textPainter.paint(context.canvas, textOffset);
  }
}
