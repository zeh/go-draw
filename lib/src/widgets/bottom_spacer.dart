import "package:flutter/widgets.dart";

class BottomSpacer extends StatelessWidget {
  BottomSpacer({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).padding.bottom;

    return Container(
      height: height,
      color: Color(0xFF2DBD3A)
    );
  }
}
