import "dart:async";

import "package:flutter/widgets.dart";
import "package:go_draw/src/config/config.dart";
import "package:go_draw/src/utils/sentry_tracking.dart";
import "package:go_draw/src/utils/analytics.dart";

import "src/routes/editor/editor.dart";
import "src/routes/other/other.dart";

void main() {
  Config.load("dev").whenComplete(() {
    print('Initializing using config "${Config.get().id}"');

    // Initialize analytics
    Analytics.setEnabled(Config.get().AnalyticsEnabled);
    Analytics.setLogEnabled(Config.get().AnalyticsLogEnabled);

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
        run();
      }, onError: (error, stackTrace) {
        SentryTracking.reportError(error, stackTrace);
      });
    } else {
      // Initialize normally
      run();
    }
  });
}

void run() {
  runApp(GoDraw());
}

class GoDraw extends StatelessWidget {
  Route generate(RouteSettings settings) {
    Route page;
    switch(settings.name){
      case "/":
        page = PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return Editor();
          },
          transitionsBuilder: (_, Animation<double> animation, Animation<double> second, Widget child) {
            return FadeTransition(
              opacity: animation,
              child: FadeTransition(
                opacity: Tween<double>(begin: 1.0, end: 0.0).animate(second),
                child: child,
              ),
            );
          }
        );
        break;
      case "/other":
        page =  PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return Other();
          },
          transitionsBuilder: (_, Animation<double> animation, Animation<double> second, Widget child) {
            return FadeTransition(
              opacity: animation,
              child: FadeTransition(
                opacity: Tween<double>(begin: 1.0, end: 0.0).animate(second),
                child: child,
              ),
            );
          }
        );
        break;
    }
    return page;
  }

  Route unknownRoute(RouteSettings settings){
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Unknown", textDirection: TextDirection.ltr,),
              Padding(padding: EdgeInsets.all(10.0)),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    color: Color(0xff0000ff),
                    child: Text("Back"),
                  ),
                )
              ]
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
        onGenerateRoute: generate,
        onUnknownRoute: unknownRoute,
        textStyle: TextStyle(),
        initialRoute: "/",
        color: Color(0xFF000000)
    );
  }
}
