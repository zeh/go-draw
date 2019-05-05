import "package:flutter/widgets.dart";
import "package:go_draw/src/data/screen/colors/screen_colors.dart";

import "color_button.dart";

class ColorBar extends StatefulWidget {
  final ScreenColors colors;
  final int currentForegroundColor;
  final int currentBackgroundColor;
  final void Function(int) onTapForegroundColor;
  final void Function(int) onTapBackgroundColor;

  ColorBar({
    @required this.colors,
    @required this.currentForegroundColor,
    @required this.currentBackgroundColor,
    @required this.onTapForegroundColor,
    @required this.onTapBackgroundColor,
  });

  @override
  _ColorBarState createState() => _ColorBarState();

}

class _ColorBarState extends State<ColorBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffe0e0e0),
      child: Column(
        children: [
          Row(
            children: generateForegroundColorButtons(),
          ),
          Row(
            children: generateBackgroundColorButtons(),
          ),
        ],
      ),
    );
  }

  List<Widget> generateForegroundColorButtons() {
    var colors = widget.colors.getForegroundColors();
    return colors.map((index) =>
      new ColorButton(
        colorIndex: index,
        color: widget.colors.get(index),
        isSelected: index == widget.currentForegroundColor,
        onTap: _handleTapForegroundColorButton,
      )
    ).toList();
  }

  List<Widget> generateBackgroundColorButtons() {
    var colors = widget.colors.getBackgroundColors();
    return colors.map((index) =>
      new ColorButton(
        colorIndex: index,
        color: widget.colors.get(index),
        isSelected: index == widget.currentBackgroundColor,
        onTap: _handleTapBackgroundColorButton,
      )
    ).toList();
  }

  void _handleTapForegroundColorButton(int index) {
    widget.onTapForegroundColor(index);
  }

  void _handleTapBackgroundColorButton(int index) {
    widget.onTapBackgroundColor(index);
  }

  @override
  dispose() {
    super.dispose();
  }
}
