import "package:flutter/widgets.dart";
import "package:go_draw/src/utils/animate.dart";
import "package:go_draw/src/utils/math_utils.dart";

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
  int _prevTool = -1;
  int _currTool = 1;
  int _nextTool = -1;
  int _numTools = 3; // TODO: Hardcoded, update later

  AniMate _toolAnimatePhase;

  @override
  void initState() {
    super.initState();

    _toolAnimatePhase = AniMate.create(
      ticker: this,
      state: this,
      duration: 600,
      curve: Curves.easeInOut,
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
          buildBackground(),
          Row(
            children: [
              ToolButton(
                assetName: "assets/tools/i-cursor.svg",
                onTap: () => setActiveTool(0), // () => widget.onTap(Tools.Text),
              ),
              ToolButton(
                assetName: "assets/tools/folder-open.svg",
                onTap: () => setActiveTool(1), // () => widget.onTap(Tools.File),
              ),
              ToolButton(
                assetName: "assets/tools/share-alt.svg",
                onTap: () => setActiveTool(2), // () => widget.onTap(Tools.Share),
              ),
            ],
          ),
        ]
      ),
    );
  }

  Widget buildBackground() {
    final double maxCarveDepth = 40;
    final double minCircleDepth = Background.HEIGHT * 0.5;
    final double maxCircleDepth = 10;
    final double minCircleRadius = 26;
    final double maxCircleRadius = 26;

    if (_toolAnimatePhase.value < 0.5) {
      // Hiding old
      double f = map(_toolAnimatePhase.value, 0, 0.5);
      double ff = Curves.easeInBack.transformInternal(f);
      double fe = Curves.easeInExpo.transformInternal(f);
      return Background(
        carveDepth: map(fe, 0, 1, maxCarveDepth, 0),
        carvePosition: (_prevTool + 1) / (_numTools + 1),
        circleDepth: map(ff, 0, 1, maxCircleDepth, minCircleDepth),
        circleRadius: map(f, 0, 1, maxCircleRadius, minCircleRadius),
      );
    } else {
      // Showing new
      double f = map(_toolAnimatePhase.value, 0.5, 1);
      // out back =  Cubic(0.175, 0.885, 0.32, 1.275);
      double ff = Curves.easeOutBack.transformInternal(f);
      double fe = Curves.easeOutExpo.transformInternal(f);
      return Background(
        carveDepth: map(fe, 0, 1, 0, maxCarveDepth),
        carvePosition: (_currTool + 1) / (_numTools + 1),
        circleDepth: map(ff, 0, 1, minCircleDepth, maxCircleDepth),
        circleRadius: map(f, 0, 1, minCircleRadius, maxCircleRadius),
      );
    }
  }

  setActiveTool(int toolIndex) {
    if (_toolAnimatePhase.isAnimating) {
      // Already animating, queues up for when this finished
      _nextTool = toolIndex;
    } else {
      // Not animating, so starts
      _nextTool = -1;
      _prevTool = _currTool;
      _currTool = toolIndex;
      _toolAnimatePhase.play(() {
        // Animate if any queued
        if (_nextTool != -1) {
          setActiveTool(_nextTool);
        }
      });
    }
  }

  // animate(double position) {
  //   _carvePosition = position;

  //   _toolAnimatePhase.stop();
  //   _toolAnimatePhase.play();
  // }

  @override
  dispose() {
    super.dispose();
    _toolAnimatePhase?.dispose();
  }
}
