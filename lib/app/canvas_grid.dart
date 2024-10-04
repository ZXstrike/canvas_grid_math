import 'package:flutter/material.dart';

class CanvasGrid extends StatefulWidget {
  const CanvasGrid({
    super.key,
    required this.sliderValueY,
    required this.sliderValueX,
    required this.selectedBox,
    required this.selectedColor,
    required this.isFalse,
  });

  final double sliderValueY;
  final double sliderValueX;
  final List<List<int>> selectedBox;
  final Color selectedColor;
  final bool isFalse;

  @override
  State<CanvasGrid> createState() => _CanvasGridState();
}

class _CanvasGridState extends State<CanvasGrid> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(
        rows: widget.sliderValueY.toInt(),
        cols: widget.sliderValueX.toInt(),
        selectedBox: widget.selectedBox,
        selectedColor: widget.selectedColor,
        isFalse: widget.isFalse,
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final int rows;
  final int cols;
  final List<List<int>> selectedBox;
  final Color selectedColor;
  final bool isFalse;

  GridPainter({
    super.repaint,
    required this.rows,
    required this.cols,
    required this.selectedBox,
    required this.selectedColor,
    required this.isFalse,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = isFalse ? Colors.red : Colors.blueGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < cols; j++) {
        final rect = Rect.fromLTWH(
          j * size.width / cols,
          i * size.height / rows,
          size.width / cols,
          size.height / rows,
        );

        canvas.drawRect(rect, paint);

        if (selectedBox.any((element) => element[0] == j && element[1] == i)) {
          final fillPaint = Paint()
            ..color = selectedColor
            ..style = PaintingStyle.fill;
          canvas.drawRect(rect, fillPaint);
        } else {
          final fillPaint = Paint()
            ..color = Colors.white70
            ..style = PaintingStyle.fill;
          canvas.drawRect(rect, fillPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
