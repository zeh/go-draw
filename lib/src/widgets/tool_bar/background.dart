import "package:flutter/widgets.dart";

class Background extends StatelessWidget {
  final double carveDepth;
  final double carvePosition;
  final double carveWidth;
  final double circleDepth;
  final double circleRadius;

  static const double HEIGHT = 50;

  Background({
    @required this.carveDepth,
    @required this.carvePosition,
    @required this.carveWidth,
    @required this.circleDepth,
    @required this.circleRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: Background.HEIGHT),
      child: CustomPaint(
        painter: BackgroundPainter(
          carveDepth: carveDepth,
          carvePosition: carvePosition,
          carveWidth: carveWidth,
          circleDepth: circleDepth,
          circleRadius: circleRadius,
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double carveDepth;
  final double carvePosition;
  final double carveWidth;
  final double circleDepth;
  final double circleRadius;
  final Color fill = Color.fromRGBO(255, 255, 255, 1.0);

  BackgroundPainter({
    @required this.carveDepth,
    @required this.carvePosition,
    @required this.carveWidth,
    @required this.circleDepth,
    @required this.circleRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = fill;
    //Rect rect = Offset.zero & size;
    //canvas.drawRect(rect, paint);

    // Calculate useful variables
    final double bleed = 100.0;
    final double width = size.width;
    final double height = Background.HEIGHT;
    final double carveControlWidthTop = carveWidth * 0.2;
    final double carveControlWidthBottom = carveWidth * 0.33;
    final double carveX = size.width * carvePosition;
    final double carveLeftX = carveX - carveWidth / 2;
    final double carveRightX = carveX + carveWidth / 2;

    // Create new path
    Path path = Path();

    // Top left
    path.moveTo(-bleed, 0);

    // Create carve
    if (carveDepth > 0) {
      // Straight line to top left corner
      path.lineTo(carveLeftX, 0);

      // Left curve to bottom
      path.cubicTo(carveLeftX + carveControlWidthTop, 0, carveX - carveControlWidthBottom, carveDepth, carveX, carveDepth);

      // Left curve to top right corner
      path.cubicTo(carveX + carveControlWidthBottom, carveDepth, carveRightX - carveControlWidthTop, 0, carveRightX, 0);

      // Top right corner
      path.lineTo(carveRightX, 0);
    }

    // Top right
    path.lineTo(width + bleed, 0);

    // Bottom right
    path.lineTo(width + bleed, height);

    // Bottom left
    path.lineTo(-bleed, height);

    // End
    path.close();

    path.addOval(Rect.fromCircle(center: Offset(carveX, circleDepth), radius: circleRadius));

    canvas.drawShadow(path, Color.fromRGBO(0, 0, 0, 1.0), 2, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(BackgroundPainter oldDelegate) => true;
}
