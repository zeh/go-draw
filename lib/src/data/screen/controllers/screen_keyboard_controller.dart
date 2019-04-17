import "dart:math" as Math;

import "package:flutter/widgets.dart";
import "package:go_draw/src/data/screen/document/screen_document.dart";

// This simulates an ANSI/eyboard screen input
// @see https://en.wikipedia.org/wiki/ANSI.SYS

class ScreenKeyboardController {
  final ScreenDocument document;

  List<int> _prevCols = [];
  List<int> _prevRows = [];

  int _col = 0;
  int _row = 0;
  int _foregroundColor = 0;
  int _backgroundColor = 0;

  ScreenKeyboardController({@required this.document});

  void setForegroundColor(int colorCode) {
    _foregroundColor = colorCode;
  }

  void setBackgroundColor(int colorCode) {
    _backgroundColor = colorCode;
  }

  void moveTo(int col, int row) {
    _col = col;
    _row = row;
  }

  void moveBy(int cols, int rows) {
    _col = Math.max(0, _col + cols);
    _row = Math.max(0, _row + rows);
  }

  void insert(int charCode) {
    document.setChar(_col, _row, charCode);
    document.setColor(_col, _row, _foregroundColor, _backgroundColor);
    _col++;
  }

  void popPosition() {
    if (_prevCols.length > 0 && _prevRows.length > 0) {
      _col = _prevCols.removeLast();
      _row = _prevRows.removeLast();
    }
  }

  void pushPosition() {
    _prevCols.add(_col);
    _prevRows.add(_row);
  }

  int getColumn() {
    return _col;
  }

  int getRow() {
    return _row;
  }
}

