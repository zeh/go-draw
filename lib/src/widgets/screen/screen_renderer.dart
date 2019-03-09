import "package:flutter/widgets.dart";

import "screen_controller.dart";
import "screen_document.dart";
import "screen_painter.dart";

class ScreenRenderer extends StatefulWidget {
  final ScreenController controller;
  final ScreenDocument document;
  final AssetImage charset;

  ScreenRenderer({
    @required this.controller,
    @required this.document,
    @required this.charset
  });

  @override
  ScreenState createState() => ScreenState();
}

class ScreenState extends State<ScreenRenderer> {
  //ScreenController _controller;

  // final index;
  // final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: ScreenPainter(
          document: widget.document,
          charset: widget.charset.resolve(createLocalImageConfiguration(context)),
        ),
      ),
    );
  }

  void addChar() {

  }
}
