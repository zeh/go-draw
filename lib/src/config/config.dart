import "dart:convert";

import "package:flutter/services.dart";
import "package:flutter/widgets.dart";

class Config {
  final String id;
  bool AnalyticsCollectionEnabled;
  bool AnalyticsLogEnabled;
  bool AnalyticsPerformanceEnabled;
  String SentryDsn;
  bool SentryEnabled;
  bool SentryLogEnabled;

  // ================================================================================================================
  // CONSTRUCTOR ----------------------------------------------------------------------------------------------------

  Config(this.id, Map<String, dynamic> map) {
    AnalyticsCollectionEnabled = map["analytics.collection.enabled"];
    AnalyticsLogEnabled = map["analytics.log.enabled"];
    AnalyticsPerformanceEnabled = map["analytics.performance.enabled"];
    SentryDsn = map["sentry.dsn"];
    SentryEnabled = map["sentry.enabled"];
    SentryLogEnabled = map["error.logs.enabled"];
  }

  // ================================================================================================================
  // STATIC INTERFACE -----------------------------------------------------------------------------------------------

  static Config instance;

  static Config get() {
    return instance;
  }

  static Future<void> load(String id) async {
    // We need to wait until everything is initialized so we can get bundle information before runApp() is ran
    // This started with https://github.com/flutter/flutter/pull/38464 mid 2019 (some time between Flutter 1.9-1.17)
    WidgetsFlutterBinding.ensureInitialized();
    var contents = await rootBundle.loadString("assets/config/configs.json");
    var allData = json.decode(contents.toString());
    var configData = allData[id];
    assert(configData != null, "Config not found for id $id");
    instance = new Config(id, configData);
  }
}
