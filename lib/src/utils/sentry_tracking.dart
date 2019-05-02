import "dart:async";
import "dart:io";

import "package:device_info/device_info.dart";
import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";
import "package:package_info/package_info.dart";
import "package:sentry/sentry.dart";

// TODO - see https://github.com/flutter/sentry
// * use Isolate.current.addErrorListener to capture uncaught errors in the root zone

class SentryTracking {
  static SentryClient client;
  static bool sendToSentry = false;
  static bool printStackTrace = false;

  static Future init({String dsn}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String deviceArchitecture = "?";
    String deviceModel = "?";
    bool devicePhysical = false;
    String osVersion = "?";

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;
      deviceArchitecture = iosInfo.utsname.machine;
      deviceModel = iosInfo.name;
      devicePhysical = iosInfo.isPhysicalDevice;
      osVersion = iosInfo.systemVersion;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      deviceArchitecture = androidInfo.device;
      deviceModel = "${androidInfo.manufacturer} ${androidInfo.model}";
      devicePhysical = androidInfo.isPhysicalDevice;
      osVersion = androidInfo.version.release;
    }

    client = new SentryClient(
      dsn: dsn,
      environmentAttributes: Event(
        loggerName: "SentryTracking",
        release: "${packageInfo.version}.${packageInfo.buildNumber}",
        environment: "-", // TODO: add environment as config
        tags: {
          "mode-debug": _isInDebugMode().toString(),
          "mode-release": kReleaseMode.toString(),
          "os-name": Platform.operatingSystem,
          "os-version": osVersion,
          "os-locale": Platform.localeName,
          "device-model": deviceModel,
          "device-physical": devicePhysical.toString(),
          "device-arch": deviceArchitecture,
        },
      ),
    );
    sendToSentry = true; // !_isInDebugMode(); // TODO: make config-dependent
    printStackTrace = true; // _isInDebugMode();

    // Captures additional errors reported by the Flutter framework
    FlutterError.onError = (FlutterErrorDetails details) {
      print("[SentryTracking] Caught FlutterError: ${details.exception}");
      if (printStackTrace) {
        FlutterError.dumpErrorToConsole(details);
      }
      if (sendToSentry) {
        Zone.current.handleUncaughtError(details.exception, details.stack);
      }
    };

    return;
  }

  static SentryClient getClient() {
    return client;
  }

  static Future<void> reportError(dynamic error, dynamic stackTrace) async {
    // Print the exception to the console
    print("[SentryTracking] Caught error: $error");
    if (printStackTrace) {
      print(stackTrace);
    }
    if (sendToSentry) {
      getClient().captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }

  static bool _isInDebugMode() {
    bool inDebugMode = false;
    // Ignored in production
    assert(inDebugMode = true);
    return inDebugMode;
  }

}
