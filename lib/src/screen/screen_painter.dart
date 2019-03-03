import 'package:flutter/material.dart';

class ScreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var paint = Paint();
    paint.color = Colors.black;

    canvas.drawRect(
      rect,
      paint,
    );
  }

  @override
  bool shouldRepaint(ScreenPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ScreenPainter oldDelegate) => false;
}
