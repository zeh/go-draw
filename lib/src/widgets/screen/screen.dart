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
  final void Function(int, int) onTapPosition;

  Screen({
    @required this.charset,
    @required this.colors,
    @required this.document,
    @required this.cursorCol,
    @required this.cursorRow,
    this.onTapPosition,
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
      child: GestureDetector(
        onTapUp: _handleScreenTapUp,
        child: ScreenRenderer(
          document: widget.document,
          charset: widget.charset,
          colors: widget.colors,
          cursorCol: widget.cursorCol,
          cursorRow: widget.cursorRow,
        ),
      ),
    );
  }

  void _handleScreenTapUp(TapUpDetails details) {
    RenderBox container = context.findRenderObject();
    Offset localPosition = container.globalToLocal(details.globalPosition);
    int col = localPosition.dx ~/ widget.charset.charWidth;
    int row = localPosition.dy ~/ widget.charset.charHeight;
    if (widget.onTapPosition != null) widget.onTapPosition(col, row);
  }
}
