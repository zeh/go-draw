import "package:flutter/widgets.dart";
import "package:go_draw/src/data/screen/charset/screen_charset.dart";
import "package:go_draw/src/data/screen/colors/screen_colors.dart";
import "package:go_draw/src/data/screen/document/screen_document.dart";

import "screen_renderer.dart";

class Screen extends StatefulWidget {
  final ScreenCharset charset;
  final ScreenColors colors;
  final ScreenDocument document;

  Screen({
    @required this.charset,
    @required this.colors,
    @required this.document,
  });

  @override
  ScreenState createState() => ScreenState();
}

class ScreenState extends State<Screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScreenRenderer(
        document: widget.document,
        charset: widget.charset,
        colors: widget.colors,
      ),
      transform: new Matrix4.rotationZ(0)//new Matrix4.rotationZ(0.5)
    );
  }
}
