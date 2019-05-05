import "package:flutter/gestures.dart";
import "package:meta/meta.dart";

// Based off https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/gestures/scale.dart#L184
// https://github.com/flutter/flutter/blob/8661d8aecd/packages/flutter/lib/src/gestures/scale.dart#L184
// and
// https://github.com/flutter/flutter/blob/8661d8aecd/packages/flutter/lib/src/gestures/recognizer.dart#L152
// But using the behavior from My Ludum Dare 24's MultiTouchSprite class

// Todo:
// * Respect state/handle threshold to start
// * Velocity for fling?
// * Handle tap, double tap, long tap?

enum _TransformState {
  ready,
  possible,
  started,
}

class TransformStartDetails {
  final int numTouches;

  TransformStartDetails({
    @required this.numTouches,
  });

  @override
  String toString() => "TransformStartDetails()";
}

class TransformUpdateDetails {
  final int numTouches;
  final Offset pivot;
  final double rotation;
  final double scale;
  final Offset translation;

  TransformUpdateDetails({
    @required this.numTouches,
    @required this.pivot,
    @required this.rotation,
    @required this.scale,
    @required this.translation,
  });

  @override
  String toString() => "TransformUpdateDetails()";
}

class TransformEndDetails {
  final int numTouches;

  TransformEndDetails({
    @required this.numTouches,
  });

  @override
  String toString() => "TransformEndDetails()";
}

typedef GestureTransformStartCallback = void Function(TransformStartDetails details);
typedef GestureTransformUpdateCallback = void Function(TransformUpdateDetails details);
typedef GestureTransformEndCallback = void Function(TransformEndDetails details);

class TouchInfo {
  final int pointer;
	Offset startingPosition;
	Offset currentPosition;

  TouchInfo({
    @required this.pointer,
    @required Offset position,
  }) {
    this.currentPosition = new Offset(position.dx, position.dy);
    this.startingPosition = new Offset(position.dx, position.dy);
  }

  @override
  String toString() => "TouchInfo(pointer: $pointer, currentLocalPos: $currentPosition, ...)";
}

class TransformGestureRecognizer extends GestureRecognizer {
  final touches = new List<TouchInfo>();
  _TransformState state = _TransformState.ready;
  double currentScale;
  double currentRotation;
  Offset currentTranslation;
  Offset currentPivot;

  GestureTransformStartCallback onStart;
  GestureTransformUpdateCallback onUpdate;
  GestureTransformEndCallback onEnd;

  TransformGestureRecognizer({
    Object debugOwner,
  }) : super(debugOwner: debugOwner) {
    _resetCurrentValues();
  }

  @override
  void addPointer(PointerDownEvent event) {
    startTrackingPointer(event.pointer);
  }

  void startTrackingPointer(int pointer) {
    // Start handling events
    GestureBinding.instance.pointerRouter.addRoute(pointer, handleEvent);

    // Add to arena
    GestureBinding.instance.gestureArena.add(pointer, this);
  }

  void stopTrackingPointer(int pointer) {
    // Stop handling events
    GestureBinding.instance.pointerRouter.removeRoute(pointer, handleEvent);
  }

  void handleEvent(PointerEvent event) {
    // print("Update pointer as ${event.pointer} => ${event.position.dx} x ${event.position.dy}");
    if (event is PointerDownEvent) {
      // A new touch
      if (touches.length > 0) {
        _dispatchOnEndCallback();
        _restartTouches();
      }

      TouchInfo touchInfo = new TouchInfo(
        pointer: event.pointer,
        position: event.position,
      );
      touches.add(touchInfo);
      _resetCurrentValues();
      _dispatchOnStartCallback();
    } else if (event is PointerMoveEvent) {
      TouchInfo touchInfo = getTouchInfo(event.pointer);
      touchInfo.currentPosition = event.position;
      _processTouches();
      _dispatchOnUpdateCallback();
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      _dispatchOnEndCallback();
      _resetCurrentValues();
      touches.removeWhere((t) => t.pointer == event.pointer);
      stopTrackingPointer(event.pointer);
      if (touches.length > 0) {
        _restartTouches();
        _dispatchOnStartCallback();
      }
    }
  }

  TouchInfo getTouchInfo(int pointer) {
    TouchInfo touchInfo = touches.firstWhere((t) => t.pointer == pointer);
    assert(touchInfo != null);
    return touchInfo;
  }

  void _resetCurrentValues() {
    currentScale = 1;
    currentRotation = 0;
    currentTranslation = Offset.zero;
    currentPivot = Offset.zero;
  }

  void _processTouches() {
    // Process all touch info, moving stuff where they need to be moved to

    if (touches.length == 1) {
      // One touch: simple drag

      // Sets the first point as pivot
      currentPivot = touches[0].startingPosition;

      // Finds translation
      currentTranslation = new Offset(
        touches[0].currentPosition.dx - touches[0].startingPosition.dx,
        touches[0].currentPosition.dy - touches[0].startingPosition.dy
      );
    } else if (touches.length >= 2) {
      // Two touches or more: drag plus scale/rotation
      // We only uses the first two touches and drop the rest

      // Sets the first point as pivot
      currentPivot = touches[0].startingPosition;

      // Finds translation
      currentTranslation = new Offset(
        touches[0].currentPosition.dx - touches[0].startingPosition.dx,
        touches[0].currentPosition.dy - touches[0].startingPosition.dy
      );

      // Finds the changes (scale and rotation) between the relationship of the first 2 points
      Offset originalDiff = touches[0].startingPosition - touches[1].startingPosition;
      Offset newDiff = touches[0].currentPosition - touches[1].currentPosition;

      currentScale = newDiff.distance / originalDiff.distance;
      currentRotation = newDiff.direction - originalDiff.direction;
    }
  }

  void _restartTouches() {
    // Resets the starting point of all touches, to allow for continuous
    // switch between using different number of touch events
    for (int i = 0; i < touches.length; i++) {
      touches[i].startingPosition = new Offset(touches[i].currentPosition.dx, touches[i].currentPosition.dy);
    }
  }

  void _dispatchOnStartCallback() {
    if (onStart != null) {
      invokeCallback<void>("onStart", () => onStart(TransformStartDetails(
        numTouches: touches.length,
      )));
    }
  }

  void _dispatchOnUpdateCallback() {
    if (onUpdate != null) {
      invokeCallback<void>("onUpdate", () => onUpdate(TransformUpdateDetails(
        numTouches: touches.length,
        pivot: new Offset(currentPivot.dx, currentPivot.dy),
        rotation: currentRotation,
        scale: currentScale,
        translation: new Offset(currentTranslation.dx, currentTranslation.dy),
      )));
    }
  }

  void _dispatchOnEndCallback() {
    if (onEnd != null) {
      invokeCallback<void>("onEnd", () => onEnd(TransformEndDetails(
        numTouches: touches.length,
      )));
    }
  }

  @override
  void acceptGesture(int pointer) {
  }

  @override
  void rejectGesture(int pointer) {
  }

  @override
  String get debugDescription => "transform";
}
