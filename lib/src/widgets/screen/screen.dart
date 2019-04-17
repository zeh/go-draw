import "package:flutter/widgets.dart";
import "package:go_draw/src/data/screen/charset/screen_charset.dart";
import "package:go_draw/src/data/screen/colors/screen_colors.dart";
import "package:go_draw/src/data/screen/document/screen_document.dart";

import "screen_renderer.dart";

/// Renders a screen widget, positioning the screen textrue accordingly

class Screen extends StatefulWidget {
  final ScreenCharset charset;
  final ScreenColors colors;
  final ScreenDocument document;
  final int cursorCol;
  final int cursorRow;

  Screen({
    @required this.charset,
    @required this.colors,
    @required this.document,
    @required this.cursorCol,
    @required this.cursorRow,
  });

  @override
  ScreenState createState() => ScreenState();
}

class ScreenState extends State<Screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScreenRenderer(
        document: widget.document,
        charset: widget.charset,
        colors: widget.colors,
        cursorCol: widget.cursorCol,
        cursorRow: widget.cursorRow,
      ),
      transform: new Matrix4.rotationZ(0)//new Matrix4.rotationZ(0.5)
    );
  }
}
