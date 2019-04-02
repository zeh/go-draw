import "dart:async";

import "package:flutter/widgets.dart";
import "package:go_draw/src/data/screen/charset/templates/screen_charset_vga.dart";
import "package:go_draw/src/data/screen/colors/templates/screen_colors_dos.dart";
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
  final changeNotifier = new StreamController<int>.broadcast();

  @override
  void dispose() {
    changeNotifier.close();
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
                child: Screen(
                  charset: ScreenCharsetVGA(context: context),
                  colors: ScreenColorsDOS(),
                  commandStream: changeNotifier.stream
                ),
              ),
            ]
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
          onTap: (charCode) => changeNotifier.sink.add(charCode)
        ),
        BottomSpacer(),
      ]
    );
  }
}
