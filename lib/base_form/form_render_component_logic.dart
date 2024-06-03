
import 'package:flutter/material.dart';

class FormRenderComponentLogic extends ChangeNotifier {
  Map<String, dynamic> map = {};

  void addParam(String key, dynamic value) {
    map[key] = value;
    notifyListeners();
  }
}