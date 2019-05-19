import "package:flutter/widgets.dart";
import "package:go_draw/src/utils/animate.dart";

import "background.dart";
import "tool_button.dart";

class ToolBar extends StatefulWidget {
  final int currentTool;
  final void Function(Tools) onTap;

  ToolBar({
    @required this.currentTool,
    @required this.onTap,
  });

  @override
  _ToolBarState createState() => _ToolBarState();
}

enum Tools {
  Text,
  File,
  Share,
}

class _ToolBarState extends State<ToolBar> with SingleTickerProviderStateMixin {

  AniMate _animate;

  @override
  void initState() {
    super.initState();

    _animate = AniMate.create(
      ticker: this,
      state: this,
      duration: 3000,
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffe0e0e0),
      height: 200,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Row(
          //   children: [
          //     ToolButton(
          //       assetName: "assets/tools/i-cursor.svg",
          //       onTap: () => widget.onTap(Tools.Text),
          //     ),
          //     ToolButton(
          //       assetName: "assets/tools/folder-open.svg",
          //       onTap: () => widget.onTap(Tools.File),
          //     ),
          //     ToolButton(
          //       assetName: "assets/tools/share-alt.svg",
          //       onTap: () => widget.onTap(Tools.Share),
          //     ),
          //   ],
          // ),
          Background(
            carveDepth: _animate.value * 40,
            carvePosition: 0.25,
            circleDepth: 0,
            circleRadius: _animate.value * 36,
          ),
        ]
      ),
    );
  }

  @override
  dispose() {
    super.dispose();
    _animate?.dispose();
  }
}
