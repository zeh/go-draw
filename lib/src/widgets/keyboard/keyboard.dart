import "package:flutter/widgets.dart";

import "keyboard_key.dart";

class Keyboard extends StatefulWidget {
  final List<List<KeyboardKey>> sets;
  final int currentSet;
  final void Function(int) onTap;

  Keyboard({
    @required this.sets,
    @required this.currentSet,
    @required this.onTap,
  });

  @override
  KeyboardState createState() => KeyboardState();
}

class KeyboardState extends State<Keyboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.currentSet < widget.sets.length); // TODO: move to state?
    List<KeyboardKey> set = widget.sets[widget.currentSet];

    return Container(
      padding: EdgeInsets.all(10.0),
      //color: Color.fromRGBO(170, 0, 0, 1),
      color: Color(0xffe0e0e0),
      child: Row(
        children: set.map((k) => getButton(k.character, k.code)).toList(),
      ),
    );
  }

  Widget getButton(String label, int charCode) {
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(charCode),
        child: Container(
          margin: EdgeInsets.all(2.0),
          padding: EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
            border: new Border.all(
              color: Color(0xffd0d0d0),
              width: 0.5,
              style: BorderStyle.solid
            ),
            color: Color(0xffffffff),
            boxShadow: [new BoxShadow(
              blurRadius: 1,
              color: Color(0x33000000),
              spreadRadius: 0,
              offset: Offset(0, 2),
            )],
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xff000000),
            ),
          ),
        ),
      ),
    );
  }

  @override
  dispose() {
    super.dispose();
  }
}
