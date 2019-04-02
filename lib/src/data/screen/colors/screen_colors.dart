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

  List<double> getAsMatrix(int numColor) {
    Color color = get(numColor);
    return [
      color.red / 255, 0, 0, 0, 0,
      0, color.green / 255, 0, 0, 0,
      0, 0, color.blue / 255, 0, 0,
      255, 255, 255, 0, 0,
    ];
  }

  ColorFilter getAsColorFilter(int numColor) {
     return ColorFilter.matrix(getAsMatrix(numColor));
  }

  Color get(int numColor) {
    assert(numColor < colors.length);
    return colors[numColor];
  }


  // ================================================================================================================
  // PRIVATE INTERFACE ----------------------------------------------------------------------------------------------

}
