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

import 'package:flutter/material.dart';
import '../base_form/form_component.dart';
import '../base_form/form_render_component.dart';
import '../base_form/form_render_component_logic.dart';
import '../base_form/form_render_component_scope.dart';
import 'package:form/form.dart';

import '../composes/group_component.dart';
import '../composes/text.dart';
import '../entities/base_composes_model.dart';

class FormDecoder {
  Widget toWidget(Map? map) {
    Widget widget;
    late BaseComposesModel baseComposesModel;
    if (map != null) {
      baseComposesModel = BaseComposesModel.formMap(map);
      widget = _convertToWidget(baseComposesModel);
    } else {
      widget = const WarningWidget(
        message: "JSON数据读取失败",
      );
    }
    return widget;
  }

  Widget _convertToWidget(BaseComposesModel component) {
    switch (component.composeType) {
      case ComposeType.form:
        return FormRenderComponentScope(
            notifier: FormRenderComponentLogic(),
            child: FormRenderComponent(
              component: component,
              children: component.children!.map((e) => _convertToWidget(e)).toList(),
            ));
      case ComposeType.layout:
        return const Row(
          children: [],
        );
      case ComposeType.group:
        return GroupComponent(
          label: component.label,
          children: component.children!.map((e) => _convertToWidget(e)).toList(),
        );
      case ComposeType.text:
      case ComposeType.textArea:
        return FormTextComponent(
          component: component,
        );
      default:
        return WarningWidget(
          type: component.composeType,
        );
    }
  }
}
