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
          height: 50,
          padding: EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            widget.assetName,
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
