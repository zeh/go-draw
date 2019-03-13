import "package:flutter/widgets.dart";

import "screen_document.dart";

class ScreenController {
  final ScreenDocument document;

  int _col = 0;
  int _row = 0;

  ScreenController({@required this.document});

  void moveTo(int col, int row) {
    _col = col;
    _row = row;
  }

  void insert(int charCode) {
    document.setChar(_col, _row, charCode);
    _col++;
  }
}

