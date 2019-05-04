import "package:flutter/widgets.dart";
import "package:go_draw/src/data/screen/charset/screen_charset.dart";
import "package:go_draw/src/data/screen/colors/screen_colors.dart";
import "package:go_draw/src/data/screen/document/screen_document.dart";

/// Renders a static screen texture, and optional static cursor

class ScreenPainter extends CustomPainter {
  final ScreenDocument document;
  final ScreenCharset charset;
  final ScreenColors colors;
  final int cursorCol;
  final int cursorRow;
  final bool renderCursor;

  ScreenPainter({
    @required this.document,
    @required this.charset,
    @required this.colors,
    @required this.cursorCol,
    @required this.cursorRow,
    @required this.renderCursor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    int defaultBackgroundColorCode = 0;
    Paint backgroundPaint = Paint();
    backgroundPaint.color = colors.get(defaultBackgroundColorCode);
    backgroundPaint.color = Color.fromRGBO(25, 25, 25, 1.0); // TODO: remove this, temporary
    canvas.drawRect(rect, backgroundPaint);

    if (charset.imageInfo != null && charset.imageInfo.image != null) {
      if (document != null) {
        final stopwatch = Stopwatch()..start();
        final double charWidth = charset.charWidth.toDouble();
        final double charHeight = charset.charHeight.toDouble();
        final int charCols = charset.imageInfo.image.width ~/ charWidth;

        int rows = document.height;
        int cols = document.width;
        int size = rows * cols;
        List<Color> charColors = List<Color>(size);
        List<RSTransform> charTransforms = List<RSTransform>(size);
        List<Rect> charRects = List<Rect>(size);

        // Initializers to reduce GC
        int charCode;
        int foregroundColor, backgroundColor;
        int pos;
        int charCol, charRow;

        double charPosFromX, charPosFromY, charPosToX, charPosToY;

        for (var row = 0; row < rows; row++) {
          for (var col = 0; col < cols; col++) {
            charCode = document.getChar(col, row);
            foregroundColor = document.getForegroundColor(col, row);
            backgroundColor = document.getBackgroundColor(col, row);
            pos = row * cols + col;

            charCol = charCode % charCols;
            charRow = charCode ~/ charCols;

            charPosFromX = charCol * charWidth;
            charPosFromY = charRow * charHeight;
            charPosToX = col * charWidth;
            charPosToY = row * charHeight;

            // Paints background space
            if (backgroundColor != defaultBackgroundColorCode) {
              backgroundPaint.color = colors.get(backgroundColor);
              canvas.drawRect(Rect.fromLTWH(charPosToX, charPosToY, charWidth, charHeight), backgroundPaint);
            }

            // Adds the foreground character to an atlas
            // TODO: detect unneeded foreground paints
            //if (charCode != 32)
            charTransforms[pos] = RSTransform.fromComponents(rotation: 0, scale: 1, anchorX: 0, anchorY: 0, translateX: charPosToX, translateY: charPosToY);
            charRects[pos] = Rect.fromLTWH(charPosFromX, charPosFromY, charWidth, charHeight);
            charColors[pos] = colors.get(foregroundColor);
          }
        }

        // Draws characters
        Paint atlasPaint = Paint();
        canvas.drawAtlas(
          charset.imageInfo.image,
          charTransforms,
          charRects,
          charColors,
          BlendMode.modulate,
          null,
          atlasPaint,
        );

        // Draws cursor
        if (renderCursor) {
          Paint cursorPaint = Paint();
          cursorPaint.color = colors.get(15);
          int cursorHeight = (charHeight * 0.2).round();
          canvas.drawRect(Rect.fromLTWH(cursorCol * charWidth, cursorRow * charHeight + charHeight - cursorHeight, charWidth, cursorHeight.toDouble()), cursorPaint);
        }

        // print('Painting for ${rows * cols} characters executed in ${stopwatch.elapsedMicroseconds / 1000}ms');
      } else {
        print("Missing document?!");
      }
    } else {
      print("PAINTING WITHOUT IMAGE");
    }
  }

  @override
  bool shouldRepaint(ScreenPainter oldDelegate) => true; // TODO: detect actual changes

  @override
  bool shouldRebuildSemantics(ScreenPainter oldDelegate) => false;
}
