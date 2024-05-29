// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class FormModel extends BaseObjectModel<Map> {
//   List<Widget> children = [];
//
//   Map<String, dynamic> params = {};
//
//   late StreamSubscription widgetValueChangeSubscription;
//
//   FormModel() {
//     widgetValueChangeSubscription = eventBus.on<WidgetValueChangedEvent>().listen((res) {
//       /// 监听子控件值变化
//     });
//   }
//
//   @override
//   Future<Map> loadData() async {
//     String content = await rootBundle.loadString("assets/data/form.json");
//     Map<String, dynamic> formAsMap = json.decode(content);
//
//     return formAsMap;
//   }
//
//   @override
//   void onCompleted(Map data) {
//     super.onCompleted(data);
//
//     children.addAll((bean!["configs"] as List).map((e) => WidgetRender(map: e)).toList());
//   }
//
//   /// 提交表单
//   Future submit() async {}
//
//   @override
//   void dispose() {
//     widgetValueChangeSubscription.cancel();
//     super.dispose();
//   }
// }
