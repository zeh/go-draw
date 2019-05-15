package com.zehfernando.godraw;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    // TODO: show splash layout, remove when first frame drawn
    // setContentView(R.layout.splash);
    // Disable status etc? https://medium.com/@diegoveloper/flutter-splash-screen-9f4e05542548
  }
}
