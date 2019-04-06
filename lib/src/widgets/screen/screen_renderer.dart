import "package:flutter/widgets.dart";
import "package:go_draw/src/data/screen/charset/screen_charset.dart";
import "package:go_draw/src/data/screen/colors/screen_colors.dart";
import "package:go_draw/src/data/screen/document/screen_document.dart";

import "screen_painter.dart";

class ScreenRenderer extends StatefulWidget {
  final ScreenDocument document;
  final ScreenCharset charset;
  final ScreenColors colors;

  ScreenRenderer({
    @required this.document,
    @required this.charset,
    @required this.colors,
  });

  @override
  ScreenState createState() => ScreenState();
}

class ScreenState extends State<ScreenRenderer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: ScreenPainter(
          document: widget.document,
          charset: widget.charset,
          colors: widget.colors,
        ),
      ),
    );
  }
}
