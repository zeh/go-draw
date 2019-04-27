import "package:flutter/gestures.dart";
import "package:flutter/widgets.dart";
import "package:go_draw/src/data/screen/charset/screen_charset.dart";
import "package:go_draw/src/data/screen/colors/screen_colors.dart";
import "package:go_draw/src/data/screen/document/screen_document.dart";
import "package:go_draw/src/utils/matrix_utils.dart";

import "screen_renderer.dart";

/// Renders a screen widget, positioning the screen texture accordingly

class Screen extends StatefulWidget {
  final ScreenCharset charset;
  final ScreenColors colors;
  final ScreenDocument document;
  final int cursorCol;
  final int cursorRow;
  final void Function(int, int) onTapPosition;

  Screen({
    @required this.charset,
    @required this.colors,
    @required this.document,
    @required this.cursorCol,
    @required this.cursorRow,
    this.onTapPosition,
  });

  @override
  ScreenState createState() => ScreenState();
}

class ScreenState extends State<Screen> {
  final Matrix4 transformMatrix = Matrix4.identity();
  double editingScale = 1;
  double editingRotation = 0;
  Offset editingFocalPoint = Offset.zero;

  final GlobalKey _screenRendererKey = GlobalKey();
  final GlobalKey _screenContainerRendererKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      behavior: HitTestBehavior.opaque,
      excludeFromSemantics: true,
      gestures: <Type, GestureRecognizerFactory>{
        PanGestureRecognizer: new GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
          () => new PanGestureRecognizer(),
          (PanGestureRecognizer instance) {
            instance
              ..dragStartBehavior = DragStartBehavior.down
              ..onStart = _handleOnPanStart
              ..onUpdate = _handleOnPanUpdate;
          },
        ),
        ScaleGestureRecognizer:
            new GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>(
          () => new ScaleGestureRecognizer(),
          (ScaleGestureRecognizer instance) {
            instance
              ..onStart = _handleScaleStart
              ..onUpdate = _handleScaleUpdate
              ..onEnd = _handleScaleEnd;
          },
        ),
      },
      child: ClipRect(
        key: _screenContainerRendererKey,
        clipBehavior: Clip.hardEdge,
        child: Container(
          transform: _getTransformMatrix(),
          child: GestureDetector(
            key: _screenRendererKey,
            onTapUp: _handleScreenTapUp,
            child: ScreenRenderer(
              document: widget.document,
              charset: widget.charset,
              colors: widget.colors,
              cursorCol: widget.cursorCol,
              cursorRow: widget.cursorRow,
            ),
          ),
        ),
      ),
    );
  }

  void _handleScreenTapUp(TapUpDetails details) {
    Offset localPosition = _globalToLocal(_screenRendererKey, details.globalPosition);
    int col = localPosition.dx ~/ widget.charset.charWidth;
    int row = localPosition.dy ~/ widget.charset.charHeight;
    if (widget.onTapPosition != null) widget.onTapPosition(col, row);
  }

  Offset _globalToLocal(GlobalKey widgetKey, Offset globalPosition) {
    RenderBox container = widgetKey.currentContext.findRenderObject();
    return container.globalToLocal(globalPosition);
  }

  void _handleOnPanStart(DragStartDetails position) {
  }

  void _handleOnPanUpdate(DragUpdateDetails details) {
    setState(() {
      transformMatrix.leftTranslate(details.delta.dx, details.delta.dy);
    });
  }

  void _handleScaleStart(ScaleStartDetails details) {
    editingScale = 1;
    editingRotation = 0;
    editingFocalPoint = Offset.zero;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      editingScale = details.scale;
      editingRotation = details.rotation;
      // We offset the focal point by the existing translation so it can resize/rotate correctly
      editingFocalPoint = _globalToLocal(_screenContainerRendererKey, details.focalPoint) - Offset(transformMatrix.getTranslation().x, transformMatrix.getTranslation().y);
    });
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    setState(() {
      _applyEditingTransformationsToMatrix(transformMatrix);
      editingScale = 1;
      editingRotation = 0;
      editingFocalPoint = Offset.zero;
    });
  }

  void _applyEditingTransformationsToMatrix(Matrix4 matrix) {
    final editingTransform = Matrix4.identity();
    editingTransform.translate(editingFocalPoint.dx, editingFocalPoint.dy);
    editingTransform.rotateZ(editingRotation);
    editingTransform.scale(editingScale);
    editingTransform.translate(-editingFocalPoint.dx, -editingFocalPoint.dy);
    matrix.setFrom(mergeTransformations(matrix, editingTransform));
  }

  Matrix4 _getTransformMatrix() {
    if (editingScale != 1 || editingRotation != 0) {
      final editingMatrix = transformMatrix.clone();
      _applyEditingTransformationsToMatrix(editingMatrix);
      return editingMatrix;
    } else {
      return transformMatrix;
    }
  }
}
