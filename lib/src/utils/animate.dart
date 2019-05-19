import "package:flutter/widgets.dart";

class AniMate {
  AnimationController _controller;
  Animation _curve;
  Animation<double> _animation;

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
        play();
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

    play();
  }

  // ================================================================================================================
	// PUBLIC INTERFACE -----------------------------------------------------------------------------------------------

  void play() {
    if (_controller != null) {
      _controller.reset();
      _controller.forward();
    }
  }

  void dispose() {
    _controller?.dispose();
  }

  double get value => _animation.value;

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
}
