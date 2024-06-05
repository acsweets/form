
import 'package:flutter/material.dart';

class FormRenderLogic extends ChangeNotifier {
  Map<String, dynamic> map = {};

  void addParam(String key, dynamic value) {
    map[key] = value;
  }
}