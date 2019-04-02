import "package:flutter/widgets.dart";
import "package:go_draw/src/data/screen/charset/screen_charset.dart";
import "package:go_draw/src/data/screen/colors/screen_colors.dart";
import "package:go_draw/src/data/screen/document/screen_document.dart";

class ScreenPainter extends CustomPainter {
  final ScreenDocument document;
  final ScreenCharset charset;
  final ScreenColors colors;

  ScreenPainter({
    @required this.document,
    @required this.charset,
    @required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size; // Rect.fromPoints(Offset(0.0, 0.0), Offset(size.));
    var paint = Paint();
    paint.color = Color(0xff000000);

    canvas.drawRect(
      rect,
      paint,
    );

    if (charset.imageInfo != null && charset.imageInfo.image != null) {
      print("PAINTING WITH IMAGE");
      //var charPaint = Paint();
      //charPaint.color = Color(0xffffffff);
      //canvas.drawImageRect(_imageInfo.image, Rect.fromPoints(Offset.zero, Offset(40, 40)), Rect.fromPoints(Offset.zero,  Offset(40, 40)), charPaint);
      if (document != null) {
        for (var row = 0; row < document.height; row++) {
          for (var col = 0; col < document.width; col++) {
            // TODO: this is temporary and not performant
            int charCode = document.getChar(col, row);
            // TODO: this shouldn't be needed, optimize somewhere else
            if (charCode != 32) {
              _placeCharacter(canvas, charCode, col, row);
            }
          }
        }
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

  _placeCharacter(Canvas canvas, int char, int col, int row) {
    int charWidth = charset.charWidth;
    int charHeight = charset.charHeight;
    int charCols = charset.imageInfo.image.width ~/ charWidth;

    int charCol = char % charCols;
    int charRow = char ~/ charCols;

    Paint charPaint = Paint();
    charPaint.color = Color(0xffffffff);

    var charPosFrom = Offset(charCol * charWidth.toDouble(), charRow * charHeight.toDouble());
    var charPosTo = Offset(col * charWidth.toDouble(), row * charHeight.toDouble());
    var charSize = Offset(charWidth.toDouble(), charHeight.toDouble());

    charPaint.colorFilter = colors.getAsColorFilter(2);
    canvas.drawRect(Rect.fromPoints(charPosTo, charPosTo + charSize), charPaint);

    charPaint.colorFilter = colors.getAsColorFilter(10);
    canvas.drawImageRect(charset.imageInfo.image, Rect.fromPoints(charPosFrom, charPosFrom + charSize), Rect.fromPoints(charPosTo, charPosTo + charSize), charPaint);

    // TODO: use atlas for speed
    //canvas.drawAtlas(atlas, transforms, rects, colors, blendMode, cullRect, paint)
  }
}
