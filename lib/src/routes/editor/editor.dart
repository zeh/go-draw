import "dart:async";

import "package:flutter/widgets.dart";

import "../../widgets/bottom_spacer.dart";
import "../../widgets/keyboard/keyboard_key.dart";
import "../../widgets/keyboard/keyboard.dart";
import "../../widgets/screen/screen.dart";
import "../../widgets/screen/screen_charset.dart";
import "../../widgets/screen/screen_colors.dart";
import "../../widgets/status_bar_spacer.dart";

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
                  charset: ScreenCharset(
                    context: context,
                    charWidth: 8,
                    charHeight: 16,
                    map: AssetImage("assets/charsets/ibmvga8_cp437_8x16.png"),
                  ),
                  colors: ScreenColors(
                    colors: [
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
                    ]
                  ),
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

// Expanded(
//           child: Flex(
//             direction: Axis.vertical,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Expanded(
//                 child: Screen(
//                   charset: AssetImage('assets/charsets/ibmvga8_cp437_8x16.png'),
//                 ),
//               ),
//             ]
//           ),
//         ),

// Container(
//           child: Screen(
//             charset: AssetImage('assets/charsets/ibmvga8_cp437_8x16.png'),
//           ),
//           constraints: BoxConstraints.expand(),
//         ),
