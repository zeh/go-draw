import "dart:async";

import "package:flutter/widgets.dart";
import "package:go_draw/src/data/screen/charset/screen_charset.dart";
import "package:go_draw/src/data/screen/colors/screen_colors.dart";
import "package:go_draw/src/data/screen/document/screen_document.dart";

import "screen_painter.dart";

/// Renders the screen texture, and control cursor blinking state

class ScreenRenderer extends StatefulWidget {
  final ScreenDocument document;
  final ScreenCharset charset;
  final ScreenColors colors;
  final int cursorCol;
  final int cursorRow;

  ScreenRenderer({
    @required this.document,
    @required this.charset,
    @required this.colors,
    @required this.cursorCol,
    @required this.cursorRow,
  });

  @override
  _ScreenRendererState createState() => _ScreenRendererState();
}

class _ScreenRendererState extends State<ScreenRenderer> {
  bool renderCursor = true;
  Timer blinkTimer;

  @override
  void initState() {
    blinkTimer = Timer.periodic(new Duration(milliseconds: 400), (timer) {
      blink();
    });

    super.initState();
  }

  void blink() {
    setState(() {
      renderCursor = !renderCursor;
    });
  }

  //int ms = new DateTime.now().millisecondsSinceEpoch;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: ScreenPainter(
          document: widget.document,
          charset: widget.charset,
          colors: widget.colors,
          cursorCol: widget.cursorCol,
          cursorRow: widget.cursorRow,
          renderCursor: renderCursor,
        ),
      ),
    );
  }
}
