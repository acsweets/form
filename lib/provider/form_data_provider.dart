import 'dart:convert';

import 'package:flutter/services.dart';

class FormDataProvider {
  Future<Map?> onLoad(String path) {
    if (path.startsWith('http') == true) {
      return _http(path);
    } else {
      return _asset(path);
    }
  }

  Future<Map?> _asset(String url) async {
    var watch = Stopwatch()..start();
    int? end, end2;
    Map? map;
    end = watch.elapsedMilliseconds;
    String content = await rootBundle.loadString(url);
    map = json.decode(content);
    end2 = watch.elapsedMilliseconds;
    return map;
  }

  Future<Map?> _http(String? url) async {
    return Map();
  }
}