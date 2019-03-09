import "package:flutter/widgets.dart";

class StatusBarSpacer extends StatelessWidget {
  StatusBarSpacer({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).padding.top;

    return Container(
      height: height,
      color: Color(0xFF2DBD3A)
    );
  }
}
