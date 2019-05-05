import "package:flutter/widgets.dart";

class ColorButton extends StatefulWidget {
  final int colorIndex;
  final Color color;
  final bool isSelected;
  final void Function(int) onTap;

  ColorButton({
    @required this.colorIndex,
    @required this.color,
    @required this.isSelected,
    @required this.onTap,
  });

  @override
  _ColorButton createState() => _ColorButton();
}

class _ColorButton extends State<ColorButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(widget.colorIndex),
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: 34.0,
          decoration: new BoxDecoration(
            border: new Border.all(
              color: Color(widget.isSelected ? 0xffffffff : 0xffd0d0d0),
              width: 3,
              style: BorderStyle.solid
            ),
            color: widget.color,
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
