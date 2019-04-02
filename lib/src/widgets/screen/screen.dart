import "dart:async";

import "package:flutter/widgets.dart";
import "package:go_draw/src/data/screen/charset/screen_charset.dart";
import "package:go_draw/src/data/screen/colors/screen_colors.dart";
import "package:go_draw/src/data/screen/controllers/screen_keyboard_controller.dart";
import "package:go_draw/src/data/screen/document/screen_document.dart";

import "screen_renderer.dart";

class Screen extends StatefulWidget {
  final ScreenCharset charset;
  final Stream<int> commandStream;
  final ScreenColors colors;

  Screen({
    @required this.charset,
    @required this.commandStream,
    @required this.colors,
  });

  @override
  ScreenState createState() => ScreenState();
}

class ScreenState extends State<Screen> {
  ScreenDocument _document;
  ScreenKeyboardController _controller;

  StreamSubscription<int> commandStreamSubscription;

  @override
  void initState() {
    super.initState();
    commandStreamSubscription = widget.commandStream.listen(insertChar);

    _document = new ScreenDocument();
    _controller = new ScreenKeyboardController(document: _document);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScreenRenderer(
        controller: _controller,
        document: _document,
        charset: widget.charset,
        colors: widget.colors,
      ),
      transform: new Matrix4.rotationZ(0)//new Matrix4.rotationZ(0.5)
    );
  }

  @override
  didUpdateWidget(Screen old) {
    super.didUpdateWidget(old);
    if (widget.commandStream != old.commandStream) {
      commandStreamSubscription.cancel();
      commandStreamSubscription = widget.commandStream.listen(insertChar);
    }
  }

  @override
  dispose() {
    super.dispose();
    commandStreamSubscription.cancel();
  }

  void insertChar(int charCode) {
    _controller.insert(charCode);
    setState(() {});
  }
}
