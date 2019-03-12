import "package:flutter/widgets.dart";

import "../../widgets/bottom_spacer.dart";
import "../../widgets/status_bar_spacer.dart";

class Editor extends StatefulWidget {
  Editor({ Key key }) : super(key: key);

  @override
  EditorState createState() => EditorState();
}

class EditorState extends State<Editor> {
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
            child: Text("Other"),
          ),
        ),
        new Expanded(
          child: new Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              'Deliver features faster',
            ),
          ),
        ),
        BottomSpacer(),
      ]
    );
  }
}
