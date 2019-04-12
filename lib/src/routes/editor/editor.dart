import "dart:async";

import "package:flutter/widgets.dart";
import "package:go_draw/src/data/screen/charset/templates/screen_charset_vga.dart";
import "package:go_draw/src/data/screen/colors/templates/screen_colors_dos.dart";
import "package:go_draw/src/data/screen/controllers/screen_keyboard_controller.dart";
import "package:go_draw/src/data/screen/document/screen_document.dart";
import "package:go_draw/src/widgets/bottom_spacer.dart";
import "package:go_draw/src/widgets/keyboard/keyboard.dart";
import "package:go_draw/src/widgets/keyboard/keyboard_key.dart";
import "package:go_draw/src/widgets/screen/screen.dart";
import "package:go_draw/src/widgets/status_bar_spacer.dart";

class Editor extends StatefulWidget {
  Editor({ Key key }) : super(key: key);

  @override
  EditorState createState() => EditorState();
}

class EditorState extends State<Editor> {
  ScreenDocument _document;
  ScreenKeyboardController _controller;
  final StreamController<ScreenDocument> _streamController = StreamController<ScreenDocument>();

  @override
  void initState() {
    super.initState();

    _document = new ScreenDocument();
    _controller = new ScreenKeyboardController(document: _document);
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
        Padding(padding: EdgeInsets.all(10.0)),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed("/other"),
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: Color(0xff0000ff),
            child: Text("Go to other screen"),
          ),
        ),
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
          onTap: (charCode) => insertChar(charCode)
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
          onTap: (code) => moveCursor(code)
        ),
        BottomSpacer(),
      ]
    );
  }

  Widget buildForStream(BuildContext context, AsyncSnapshot<ScreenDocument> snapshot) {
    return Screen(
      charset: ScreenCharsetVGA(context: context),
      colors: ScreenColorsDOS(),
      document: snapshot.data,
    );
  }

  void insertChar(int charCode) {
    // TODO: allow changing the color
    _controller.setForegroundColor(10);
    _controller.setBackgroundColor(2);
    _controller.insert(charCode);
    _streamController.sink.add(_document);
  }

  void moveCursor(int code) {
    int cols = 0;
    int rows = 0;
    if (code == 0) rows = -1;
    if (code == 1) rows = 1;
    if (code == 2) cols = -1;
    if (code == 3) cols = 1;
    _controller.moveBy(cols, rows);
    _streamController.sink.add(_document);
  }
}
