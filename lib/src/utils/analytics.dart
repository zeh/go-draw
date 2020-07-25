// TODO: Disabled Firebase for now
// import "package:firebase_analytics/firebase_analytics.dart";
// import "package:firebase_analytics/observer.dart";

class Analytics {
  // static FirebaseAnalytics analytics = FirebaseAnalytics();
  // static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  static bool logEnabled = true;

  static init() {}

  // For more examples: https://github.com/flutter/plugins/blob/master/packages/firebase_analytics/example/lib/main.dart
  static Future<void> trackScreen(String name) async {
    // await analytics.setCurrentScreen(
    //   screenName: name,
    //   screenClassOverride: name,
    // );
    if (logEnabled) print("[Analytics] trackScreen: " + name);
  }

  static Future<void> setEnabled(bool enabled) async {
    // await analytics.setAnalyticsCollectionEnabled(enabled);
  }

  static Future<void> setLogEnabled(bool enabled) async {
    logEnabled = enabled;
  }
}
