import "dart:math" as Math;

class ScreenDocument {
  int _width = 0;
  int _height = 0;

  List<int> _chars;
  List<int> _foregroundColors;
  List<int> _backgroundColors;

  int defaultChar = 32;
  int defaultForegroundColor = 7;
  int defaultBackgroundColor = 0;

  ScreenDocument();

  int get width => _width;

  int get height => _height;

  void setChar(int col, int row, int char) {
    resizeToFitIfNeeded(col, row);
    var pos = getPos(col, row);
    _chars[pos] = char;
  }

  void setColor(int col, int row, int foregroundColor, int backgroundColor) {
    resizeToFitIfNeeded(col, row);
    var pos = getPos(col, row);
    _foregroundColors[pos] = foregroundColor;
    _backgroundColors[pos] = backgroundColor;
  }

  void resizeToFitIfNeeded(int col, int row) {
    if (col >= _width || row >= _height) {
      resize(Math.max(col + 1, _width), Math.max(row + 1, _height));
    }
  }

  int getChar(int col, int row) {
    return _chars[getPos(col, row)];
  }

  int getPos(int col, int row) {
    return row * _width + col;
  }

  void resize(int newWidth, int newHeight) {
    if (newWidth != _width || newHeight != _height) {
      // Create a new list
      var newLength = newWidth * newHeight;
      var newChars = List<int>.generate(newLength, (i) => defaultChar);
      var newForegroundColors = List<int>.generate(newLength, (i) => defaultForegroundColor);
      var newBackgroundColors = List<int>.generate(newLength, (i) => defaultBackgroundColor);

      // Copy data
      for (int row = 0; row < Math.min(newHeight, _height); row++) {
        for (int col = 0; col < Math.min(newWidth, _width); col++) {
          var oldPos = row * _width + col;
          var newPos = row * newWidth + col;
          newChars[newPos] = _chars[oldPos];
          newForegroundColors[newPos] = _foregroundColors[oldPos];
          newBackgroundColors[newPos] = _backgroundColors[oldPos];
        }
      }

      // Set current list to new list
      _chars = newChars;
      _foregroundColors = newForegroundColors;
      _backgroundColors = newBackgroundColors;
      _width = newWidth;
      _height = newHeight;
    }
  }
}

