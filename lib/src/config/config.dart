import "dart:convert";

import "package:flutter/services.dart";

class Config {

  final String id;
  bool AnalyticsEnabled;
  bool AnalyticsLogEnabled;
  String SentryDsn;
  bool SentryEnabled;
  bool SentryLogEnabled;

  // ================================================================================================================
  // CONSTRUCTOR ----------------------------------------------------------------------------------------------------

  Config(this.id, Map<String, dynamic> map) {
    AnalyticsEnabled = map["analytics.enabled"];
    AnalyticsLogEnabled = map["analytics.log.enabled"];
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
    var contents = await rootBundle.loadString("assets/config/configs.json");
    var allData = json.decode(contents.toString());
    var configData = allData[id];
    assert(configData != null, "Config not found for id $id");
    instance = new Config(id, configData);
  }
}