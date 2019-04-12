import "package:firebase_analytics/firebase_analytics.dart";
import "package:firebase_analytics/observer.dart";

class Analytics {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  static init() {

  }

  // For more examples: https://github.com/flutter/plugins/blob/master/packages/firebase_analytics/example/lib/main.dart
  static Future<void> trackScreen(String name) async {
    await analytics.setCurrentScreen(
      screenName: name,
      screenClassOverride: name,
    );
    print("Analytics :: trackScreen: " + name);
  }
}
