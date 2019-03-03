import 'package:flutter/material.dart';

import 'screen_painter.dart';

class Screen extends StatelessWidget {
  Screen(); // {@required this.index, @required this.onPress}

  // final index;
  // final Function onPress;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ScreenPainter(),
      child: Center(
        child: Text(
          'Once upon a time...',
          style: const TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.w900,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
