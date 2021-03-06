import "dart:async";

import "package:flutter/widgets.dart";
import "package:go_draw/src/data/screen/charset/templates/screen_charset_vga.dart";
import "package:go_draw/src/data/screen/colors/screen_colors.dart";
import "package:go_draw/src/data/screen/colors/templates/screen_colors_dos.dart";
import "package:go_draw/src/data/screen/controllers/screen_keyboard_controller.dart";
import "package:go_draw/src/data/screen/document/screen_document.dart";
import "package:go_draw/src/utils/analytics.dart";
import "package:go_draw/src/widgets/bottom_spacer.dart";
import "package:go_draw/src/widgets/color_bar/color_bar.dart";
import "package:go_draw/src/widgets/keyboard/keyboard.dart";
import "package:go_draw/src/widgets/keyboard/keyboard_key.dart";
import "package:go_draw/src/widgets/screen/screen.dart";
import "package:go_draw/src/widgets/status_bar_spacer.dart";
import "package:go_draw/src/widgets/tool_bar/tool_bar.dart";

class Editor extends StatefulWidget {
  Editor({ Key key }) : super(key: key);

  @override
  EditorState createState() => EditorState();
}

class EditorState extends State<Editor> {
  ScreenDocument _document;
  ScreenColors _colors;
  ScreenKeyboardController _controller;
  final StreamController<ScreenDocument> _streamController = StreamController<ScreenDocument>();

  @override
  void initState() {
    super.initState();

    Analytics.trackScreen("/");

    _document = new ScreenDocument();
    _colors = new ScreenColorsDOS();
    _controller = new ScreenKeyboardController(document: _document);
    _controller.setForegroundColor(10);
    _controller.setBackgroundColor(2);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        StatusBarSpacer(),
        // Padding(padding: EdgeInsets.all(10.0)),
        // GestureDetector(
        //   onTap: () => Navigator.of(context).pushNamed("/other"),
        //   child: Container(
        //     padding: EdgeInsets.all(10.0),
        //     color: Color(0xff0000ff),
        //     child: Text("Go to other screen"),
        //   ),
        // ),
        Expanded(
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: StreamBuilder<ScreenDocument>(
                  stream: _streamController.stream,
                  initialData: _document,
                  builder: buildForStream,
                ),
              ),
            ],
          ),
        ),
        ColorBar(
          colors: _colors,
          currentForegroundColor: _controller.getForegroundColor(),
          currentBackgroundColor: _controller.getBackgroundColor(),
          onTapForegroundColor: _handleTapForegroundColor,
          onTapBackgroundColor: _handleTapBackgroundColor,
        ),
        Keyboard(
          currentSet: 0,
          sets: [
            [
              KeyboardKey(character: "░", code: 176),
              KeyboardKey(character: "▒", code: 177),
              KeyboardKey(character: "▓", code: 178),
              KeyboardKey(character: "█", code: 219),
              KeyboardKey(character: "▀", code: 223),
              KeyboardKey(character: "▄", code: 220),
              KeyboardKey(character: "▌", code: 221),
              KeyboardKey(character: "▐", code: 222),
              KeyboardKey(character: "■", code: 254),
              KeyboardKey(character: "·", code: 250), // or 249 ∙
            ],
          ],
          onTap: (charCode) => _insertChar(charCode)
        ),
        Keyboard(
          currentSet: 0,
          sets: [
            [
              KeyboardKey(character: "↑", code: 0),
              KeyboardKey(character: "↓", code: 1),
              KeyboardKey(character: "←", code: 2),
              KeyboardKey(character: "→", code: 3),
            ],
          ],
          onTap: (code) => _moveCursor(code)
        ),
        ToolBar(
          currentTool: 1,
          onTap: (Tools toolId) => print("TAP on tool $toolId"),
        ),
        BottomSpacer(),
      ]
    );
  }

  Widget buildForStream(BuildContext context, AsyncSnapshot<ScreenDocument> snapshot) {
    return Screen(
      charset: ScreenCharsetVGA(context: context),
      colors: _colors,
      document: snapshot.data,
      cursorCol: _controller.getColumn(),
      cursorRow: _controller.getRow(),
      onTapPosition: _handleTapPosition,
    );
  }

  void _insertChar(int charCode) {
    _controller.insert(charCode);
    _streamController.sink.add(_document);
  }

  void _moveCursor(int code) {
    int cols = 0;
    int rows = 0;
    if (code == 0) rows = -1;
    if (code == 1) rows = 1;
    if (code == 2) cols = -1;
    if (code == 3) cols = 1;
    setState(() {
      _controller.moveBy(cols, rows);
      _streamController.sink.add(_document);
    });
  }

  void _handleTapPosition(int col, int row) {
    setState(() {
      _controller.moveTo(col, row);
    });
  }

  void _handleTapForegroundColor(int colorNum) {
    setState(() {
      _controller.setForegroundColor(colorNum);
    });
  }

  void _handleTapBackgroundColor(int colorNum) {
    setState(() {
      _controller.setBackgroundColor(colorNum);
    });
  }
}
