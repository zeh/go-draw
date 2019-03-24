import "dart:async";

import "package:flutter/widgets.dart";

import "screen_charset.dart";
import "screen_colors.dart";
import "screen_controller.dart";
import "screen_document.dart";
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
  ScreenController _controller;

  StreamSubscription<int> commandStreamSubscription;

  @override
  void initState() {
    super.initState();
    commandStreamSubscription = widget.commandStream.listen(insertChar);

    _document = new ScreenDocument();
    _controller = new ScreenController(document: _document);
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
