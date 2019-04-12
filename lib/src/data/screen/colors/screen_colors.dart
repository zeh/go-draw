import "dart:ui";

import "package:flutter/foundation.dart";

class ScreenColors {
  final List<Color> colors;


  // ================================================================================================================
  // CONSTRUCTOR ----------------------------------------------------------------------------------------------------

  ScreenColors({
    @required this.colors,
  });


  // ================================================================================================================
	// PUBLIC INTERFACE -----------------------------------------------------------------------------------------------

  /**
   * Returns a color matrix for a color filter that converts a black-and-white opaque input to
   * a transparent image of a given color
   */
  List<double> getStampMatrix(int numColor) {
    Color color = get(numColor);
    return [
      color.red / 255, 0, 0, 0, 0,
      0, color.green / 255, 0, 0, 0,
      0, 0, color.blue / 255, 0, 0,
      255, 255, 255, 0, 0,
    ];
  }

  ColorFilter getStampColorFilter(int numColor) {
     return ColorFilter.matrix(getStampMatrix(numColor));
  }

  /**
   * Returns a color matrix for a color filter that converts a black-and-white opaque input to
   * a opaque image of a given foreground and background color
   */
  List<double> getDuotoneMatrix(int numColorForeground, int numColorBackground) {
    Color foregroundColor = get(numColorForeground);
    Color backgroundColor = get(numColorBackground);
    return [
      (foregroundColor.red - backgroundColor.red) / 255, 0, 0, 0, backgroundColor.red.toDouble(),
      0, (foregroundColor.green - backgroundColor.green) / 255, 0, 0, backgroundColor.green.toDouble(),
      0, 0, (foregroundColor.blue - backgroundColor.blue) / 255, 0, backgroundColor.blue.toDouble(),
      0, 0, 0, 1, 0,
    ];
  }

  ColorFilter getDuotoneColorFilter(int numColorForeground, int numColorBackground) {
     return ColorFilter.matrix(getDuotoneMatrix(numColorForeground, numColorBackground));
  }

  /**
   * Returns a color matrix for a color filter that converts a black-and-white opaque input to
   * a transparent image of a given paint's color
   */
  List<double> getSimpleMatrix() {
    return [
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      255, 255, 255, 0, 0,
    ];
  }

  ColorFilter getSimpleColorFilter() {
     return ColorFilter.matrix(getSimpleMatrix());
  }

  Color get(int numColor) {
    assert(numColor < colors.length);
    return colors[numColor];
  }


  // ================================================================================================================
  // PRIVATE INTERFACE ----------------------------------------------------------------------------------------------

}
