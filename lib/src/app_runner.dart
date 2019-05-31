import "dart:async";

import "package:flutter/widgets.dart";
import "package:go_draw/src/config/config.dart";
import "package:go_draw/src/go_draw.dart";
import "package:go_draw/src/utils/perf.dart";
import "package:go_draw/src/utils/sentry_tracking.dart";
import "package:go_draw/src/utils/analytics.dart";

class AppRunner {
  static void runWithConfigId(String id) {
    Config.load(id).whenComplete(() {
      print('Initializing using config "${Config.get().id}"');

      // Initialize analytics
      Analytics.setEnabled(Config.get().AnalyticsCollectionEnabled);
      Analytics.setLogEnabled(Config.get().AnalyticsLogEnabled);

      // Initialize performance tracking
      Perf.setEnabled(Config.get().AnalyticsPerformanceEnabled);

      if (Config.get().SentryEnabled) {
        // Initialize with error interception
        runZoned<Future<void>>(() async {
          await SentryTracking.init(
            dsn: Config.get().SentryDsn,
            shouldPrintStackTrace: Config.get().SentryLogEnabled,
            tags: {
              "config-id": Config.get().id,
            },
          );
          _run();
        }, onError: (error, stackTrace) {
          SentryTracking.reportError(error, stackTrace);
        });
      } else {
        // Initialize normally
        _run();
      }
    });
  }

  static void _run() {
    runApp(GoDraw());
  }
}
