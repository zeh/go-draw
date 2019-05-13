import "package:flutter/widgets.dart";

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

class _ToolBarState extends State<ToolBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffe0e0e0),
      child: Row(
        children: [
          ToolButton(
            assetName: "assets/tools/i-cursor.svg",
            onTap: () => widget.onTap(Tools.Text),
          ),
          ToolButton(
            assetName: "assets/tools/folder-open.svg",
            onTap: () => widget.onTap(Tools.File),
          ),
          ToolButton(
            assetName: "assets/tools/share-alt.svg",
            onTap: () => widget.onTap(Tools.Share),
          ),
        ],
      ),
    );
  }

  @override
  dispose() {
    super.dispose();
  }
}
