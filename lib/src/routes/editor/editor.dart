import "dart:async";

import "package:flutter/widgets.dart";

import "../../widgets/bottom_spacer.dart";
import "../../widgets/screen/screen.dart";
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
        Flex(
          direction: Axis.horizontal,
          children: [
            getButton("░", 176),
            getButton("▒", 177),
            getButton("▓", 178),
            getButton("█", 219),
            getButton("▀", 223),
            getButton("▄", 220),
            getButton("▌", 221),
            getButton("▐", 222),
            getButton("■", 254),
            getButton("·", 250), // or 249 ∙
          ]
        ),
        Expanded(
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Screen(
                  charset: AssetImage("assets/charsets/ibmvga8_cp437_8x16.png"),
                  commandStream: changeNotifier.stream
                ),
              ),
            ]
          ),
        ),
        BottomSpacer(),
      ]
    );
  }

  Widget getButton(String label, int charCode) {
    return GestureDetector(
      onTap: () => changeNotifier.sink.add(charCode),
      child: Container(
        margin: EdgeInsets.all(2.0),
        padding: EdgeInsets.all(10.0),
        color: Color(0xff0000ff),
        child: Text(label),
      )
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
