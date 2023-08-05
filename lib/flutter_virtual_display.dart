// ignore_for_file: avoid_print

import 'package:flutter/services.dart';

class FlutterVirtualDisplay {
  static const _channel =
      MethodChannel('com.virtual_display.flutter_virtual_display');

  static Future<int?> createDisplay({
    required String name,
    required int width,
    required int height,
  }) async {
    try {
      var result = await _channel.invokeMethod('createDisplay', {
        "name": name,
        "width": width,
        "height": height,
      });
      return result["displayID"];
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> removeDisplay(int displayId) async {
    await _channel.invokeMethod('removeDisplay', {
      "displayID": displayId,
    });
  }
}
