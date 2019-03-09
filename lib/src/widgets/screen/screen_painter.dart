import "package:flutter/widgets.dart";

import "screen_document.dart";

class ScreenPainter extends CustomPainter {
  final ScreenDocument document;
  final ImageStream charset;

  ImageInfo _imageInfo;
  bool _isDirty;

  ScreenPainter({
    @required this.document,
    @required this.charset
  }) {
    _isDirty = false;
    charset.addListener(_updateImage);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size; // Rect.fromPoints(Offset(0.0, 0.0), Offset(size.));
    var paint = Paint();
    paint.color = Color(0xff000000);

    canvas.drawRect(
      rect,
      paint,
    );

    if (_imageInfo != null && _imageInfo.image != null) {
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
        _placeCharacter(canvas, 176, 4, 4);
        _placeCharacter(canvas, 177, 5, 4);
        _placeCharacter(canvas, 178, 6, 4);
        _placeCharacter(canvas, 219, 7, 4);
      } else {
        print("Missing document?!");
      }
    } else {
      print("PAINTING WITHOUT IMAGE");
    }

    _isDirty = false;
  }

  @override
  bool shouldRepaint(ScreenPainter oldDelegate) => _isDirty;

  @override
  bool shouldRebuildSemantics(ScreenPainter oldDelegate) => false;

  _updateImage(ImageInfo imageInfo, bool synchronousCall) {
    _imageInfo = imageInfo;
    _isDirty = true;
    print("HAS CHANGED");
  }

  _placeCharacter(Canvas canvas, int char, int col, int row) {
    int charWidth = 8;
    int charHeight = 16;
    int charCols = _imageInfo.image.width ~/ charWidth;

    int charCol = char % charCols;
    int charRow = char ~/ charCols;

    Paint charPaint = Paint();
    charPaint.color = Color(0xffffffff);

    var charPosFrom = Offset(charCol * charWidth.toDouble(), charRow * charHeight.toDouble());
    var charPosTo = Offset(col * charWidth.toDouble(), row * charHeight.toDouble());
    var charSize = Offset(charWidth.toDouble(), charHeight.toDouble());

    canvas.drawImageRect(_imageInfo.image, Rect.fromPoints(charPosFrom, charPosFrom + charSize), Rect.fromPoints(charPosTo, charPosTo + charSize), charPaint);

    //canvas.drawAtlas(atlas, transforms, rects, colors, blendMode, cullRect, paint)

  }
}
