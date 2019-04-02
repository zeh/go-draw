import "dart:ui";

import "../screen_colors.dart";

class ScreenColorsDOS extends ScreenColors {
  ScreenColorsDOS() : super(colors: [
    Color.fromRGBO(0,   0,   0,   1), // 0 = Black
    Color.fromRGBO(0,   0,   170, 1), // 1 = Blue
    Color.fromRGBO(0,   170, 0,   1), // 2 = Green
    Color.fromRGBO(0,   170, 170, 1), // 3 = Cyan
    Color.fromRGBO(170, 0,   0,   1), // 4 = Red
    Color.fromRGBO(170, 0,   170, 1), // 5 = Purple
    Color.fromRGBO(170, 85,  0,   1), // 6 = Yellow
    Color.fromRGBO(170, 170, 170, 1), // 7 = White
    Color.fromRGBO(85,  85,  85,  1), // 8 = Gray
    Color.fromRGBO(85,  85,  255, 1), // 9 = Light Blue
    Color.fromRGBO(85,  255, 85,  1), // A = Light Green
    Color.fromRGBO(85,  255, 255, 1), // B = Light Cyan
    Color.fromRGBO(255, 85,  85,  1), // C = Light Red
    Color.fromRGBO(255, 85,  255, 1), // D = Light Purple
    Color.fromRGBO(255, 255, 85,  1), // E = Light Yellow
    Color.fromRGBO(255, 255, 255, 1), // F = Bright White
  ]);
}
