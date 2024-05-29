// widget_factory.dart
import 'package:flutter/material.dart';
import 'package:form/composes/compose_widegt.dart';


typedef WidgetFactory = Widget Function(Map<String, dynamic>);

final Map<String, WidgetFactory> _widgetFactories = {
  'Container': (props) => Container(
        color: Color(int.parse(props['color'].substring(1), radix: 16)),
        child: _createWidgetFromJson(props['child']),
      ),
  'Text': (props) => Text(props['text']),
  // 添加更多组件工厂...
};

Widget _createWidgetFromJson(Map<String, dynamic>? jsonData) {
  if (jsonData == null) return const SizedBox.shrink();

  final String type = jsonData['type'];
  final WidgetFactory? factory = _widgetFactories[type];

  if (factory == null) {
    throw Exception('Unknown widget type: $type');
  }

  return factory(jsonData..remove('type'));
}

final Map<String, Widget> composes = {
  // 'text': const TextWidget(),
  "textArea": const TextAreaWidget(), //描述输入
  "line": const LineWidget(), // 线
  "pager": const PagerWidget(), //
  "title": const TitleWidget(), //输入标题组件
  "selectBox": const SelectBoxWidget(), //选择框
  "checkBox": const CheckBoxWidget(), //
  "switch": const SwitchWidget(), //开关
  "date": const DateWidget(), //日期组件
  "dateRange": const DateRangeWidget(),
  // 添加更多组件工厂...
};
