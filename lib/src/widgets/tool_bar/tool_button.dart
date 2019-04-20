import "package:flutter/widgets.dart";

import "package:flutter_svg/flutter_svg.dart";

class ToolButton extends StatefulWidget {
  final String assetName;
  final void Function() onTap;

  ToolButton({
    @required this.assetName,
    @required this.onTap,
  });

  @override
  _ToolButton createState() => _ToolButton();
}

class _ToolButton extends State<ToolButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
            border: new Border.all(
              color: Color(0xffd0d0d0),
              width: 0.5,
              style: BorderStyle.solid
            ),
            color: Color(0xffffffff),
          ),
          child: SvgPicture.asset(
            widget.assetName,
            width: 20,
            height: 20,
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
