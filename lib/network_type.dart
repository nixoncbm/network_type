
import 'dart:async';

import 'package:flutter/services.dart';

class NetworkType {
  static const MethodChannel _channel =
      const MethodChannel('com.nixon/network_type');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getNetworkType');
    return version;
  }
}
