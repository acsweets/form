
import 'package:flutter/material.dart';
import 'package:form/form.dart';

import '../provider/form_data_provider.dart';
import 'form_decode.dart';


mixin class Loader {
  FormDecoder? _decoder;

  Future<Widget?> parse(BuildContext context, {required String url}) async {
    Widget widget;
    try {
      Map? map = await const FormDataProvider().onLoad(url);
      _decoder ??= FormDecoder();
      widget = _decoder!.toWidget(map);
      print(widget);
      return widget;
    } catch (e) {
      widget = const WarningWidget(
        type: ComposeType.form,
      );
    }
    return widget;

  }
}