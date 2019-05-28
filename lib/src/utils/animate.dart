import "package:flutter/widgets.dart";

class AniMate {
  AnimationController _controller;
  Animation _curve;
  Animation<double> _animation;
  void Function() _onComplete;


  // ================================================================================================================
	// STATIC INTERFACE -----------------------------------------------------------------------------------------------

  static AniMate create({
    @required TickerProvider ticker,
    @required State state,
    @required int duration,
    Curve curve,
  }) {
    final animator = new AniMate(
      ticker: ticker,
      state: state,
      duration: duration,
      curve: curve,
    );
    return animator;
  }


  // ================================================================================================================
  // CONSTRUCTOR ----------------------------------------------------------------------------------------------------

  AniMate({
    @required TickerProvider ticker,
    @required State state,
    @required int duration,
    Curve curve,
  }) {
    _controller = new AnimationController(
      duration: Duration(milliseconds: duration),
      vsync: ticker,
    );

    // TODO: extract into an onComplete
    _controller.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        if (_onComplete != null) _onComplete();
      }
    });

    Animation animationCurve = curve == null ? null : CurvedAnimation(parent: _controller, curve: curve);

    _animation = new Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationCurve == null ? _controller : animationCurve);

    _animation.addListener(() {
      state.setState((){});
    });
  }


  // ================================================================================================================
	// PUBLIC INTERFACE -----------------------------------------------------------------------------------------------

  Future<void> play([void Function() onComplete]) {
    if (_controller != null) {
      _controller.reset();
      _controller.forward();

      _onComplete = onComplete;
    }
  }

  void stop() {
    if (_controller != null) {
      _controller.reset();
      _controller.stop();
    }
  }

  void dispose() {
    _controller?.dispose();
  }

  double get value => _animation.value;

  bool get isAnimating {
    return _controller.isAnimating;
  }
}
