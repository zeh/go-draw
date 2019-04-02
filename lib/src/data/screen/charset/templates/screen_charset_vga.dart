import 'package:flutter/widgets.dart';

import "../screen_charset.dart";

class ScreenCharsetVGA extends ScreenCharset {
  ScreenCharsetVGA({@required BuildContext context}) : super(
    context: context,
    charWidth: 8,
    charHeight: 16,
    map: AssetImage("assets/charsets/ibmvga8_cp437_8x16.png"),
  );
}
