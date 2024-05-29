// class _DataSource {
//   final Map? layout;
//   final Map? data;
//   final Map? methodMap;
//
//   _DataSource({this.layout, this.data, this.methodMap});
// }
//
// class Decoder {
//   final FairBundle _loader = FairBundle();
//   final FairDecoder _decoder = FairDecoder();
//   final String? page;
//   final Map<String, dynamic>? dataSource;
//   final String? url;
//   _DataSource? _source;
//
//   Decoder(this.page, {this.dataSource, this.url});
//
//   bool get hasResolved => _source != null;
//
//   Future<void> resolve(BuildContext context) async {
//     var jsonBean = await _loader.obtain(context).onLoad(url, _decoder, cache: true, h: const {'fairVersion': '$fairVersion#$flutterVersion'});
//     Map? data = <dynamic, dynamic>{};
//     Map? methodMap = <String, dynamic>{};
//
//     var d = jsonBean?.remove('data');
//     methodMap = jsonBean?['methodMap'] ?? <String, dynamic>{};
//     jsonBean?.remove('methodMap');
//
//     if (d != null) {
//       data.addAll(d);
//     }
//     if (dataSource != null) {
//       data.addAll(dataSource!);
//     }
//     var s = _DataSource(layout: jsonBean, data: data, methodMap: methodMap);
//     _source = s;
//     return Future.value();
//   }
//
//   Widget toWidget(BuildContext context) {
//     return trackExecution('[Fair] parse as widget: $page', () {
//       var source = _source;
//       var layout = source?.layout;
//       var data = source?.data;
//       var methodMap = source?.methodMap;
//       var widget = _convert(context, layout!, methodMap, data: data);
//       return widget;
//     });
//   }
//
//   Widget _convert(BuildContext context, Map map, Map? methodMap, {Map? data}) {
//     var app = FairApp.of(context);
//     var bound = app?.bindData[page];
//     if (data != null && data.isNotEmpty) {
//       log('[Fair] binding data => $data');
//       bound ??= BindingData(app?.modules);
//       bound.data = data;
//     }
//
//     var dynamicBuilder;
//     var proxy = app?.proxy;
//     final dynamicBuilders = app?.dynamicWidgetBuilder?.map((e) => e?.call(proxy as ProxyMirror?, page, bound, bundle: url));
//     if (dynamicBuilders == null || dynamicBuilders.isEmpty) {
//       dynamicBuilder = DynamicWidgetBuilder(proxy as ProxyMirror?, page, bound, bundle: url);
//     } else {
//       dynamicBuilder =
//           dynamicBuilders.firstWhere((element) => element?.convert(context, map, methodMap) != null, orElse: () => null);
//     }
//     Widget w =(dynamicBuilder ?? DynamicWidgetBuilder(proxy as ProxyMirror?, page, bound, bundle: url)).convert(context, map, methodMap) ??
//         WarningWidget(parentContext:context,name: page, url: url, error: 'tag name not supported yet');
//     return w;
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form/composes/compose_widegt.dart';

import '../bean/base_composes_model.dart';
import '../composes/form_compose.dart';
import 'package:form/form.dart';

import '../provider/form_data_provider.dart';

mixin class Loader {
  FormDecoder? _decoder;
  String? bundleType;

  Future<Widget?> parse(BuildContext context, {required String url}) async {
    Widget widget;
    try {
      Map? map = await FormDataProvider().onLoad(url);
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

class FormDecoder {
  Widget toWidget(Map? map) {
    Widget widget;
    late BaseComposesModel baseComposesModel;
    if (map != null) {
      baseComposesModel = BaseComposesModel.formMap(map);
      widget = _convertToWidget(baseComposesModel);
    } else {
      widget = const WarningWidget(
        message: "jSON数据读取失败",
      );
    }
    return widget;
  }

  /// 表单组件怎么拿到和管理子组件的状态？
  /// 表单中怎么知道需要提交哪些字段，提交时遍历 表单组件的key 获得要提交的的参数信息
  /// 从树里找到这些信息
  /// 获得表单的状态，组件改变（回调出去在表单里做处理）去调用表单里的方法
  Widget _convertToWidget(BaseComposesModel component) {
    switch (component.composeType) {
      case ComposeType.form:
        return FormCompose(
          baseComposes: component,
          children: component.children!.map((e) => _convertToWidget(e)).toList(),
        );
      case ComposeType.layout:
        return const Row(
          children: [],
        );
      case ComposeType.group:
        return Container();
      case ComposeType.text:
        return TextWidget(
          composes:component ,
        );
      case ComposeType.textArea:
        return Text("");
      default:
        return WarningWidget(
          type: component.composeType,
        );
    }
  }
}


