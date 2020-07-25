// TODO: Disabled Firebase for now
// import "package:firebase_performance/firebase_performance.dart";

// For more info: https://pub.dev/packages/firebase_performance

class Perf {
  static init() {}

  static Future<void> setEnabled(bool enabled) async {
    // await FirebasePerformance.instance.setPerformanceCollectionEnabled(enabled);
  }

  // TODO: track performance
  // Example:
  // final Trace myTrace = FirebasePerformance.instance.newTrace("test_trace");
  // myTrace.start();
  // myTrace.incrementMetric("test_hit", 1);
  // myTrace.stop();
}
