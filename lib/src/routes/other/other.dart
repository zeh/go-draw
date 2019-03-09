import "package:flutter/widgets.dart";

class Other extends StatelessWidget {
  Other({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Home Page", textDirection: TextDirection.ltr,),
        Padding(padding: EdgeInsets.all(10.0)),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed("/other"),
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: Color(0xff0000ff),
            child: Text("Go to Other Page again"),
          ),
        ),
        Padding(padding: EdgeInsets.all(10.0)),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed("/abcd"),
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: Color(0xff0000ff),
            child: Text("Unkown Route"),
          ),
        ),
        Padding(padding: EdgeInsets.all(10.0)),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: Color(0xff0000ff),
            child: Text("Go back"),
          ),
        )
      ],
    );
  }
}
