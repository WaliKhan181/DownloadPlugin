import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPluginCheck {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_check');

  static showToast(String url){
    _channel.invokeMethod("showToast",{"url":url});
  }
}
