// import 'package:flutter/material.dart';
//
// import 'custom_checkbox_widget.dart';
// import 'custom_date_range_widget.dart';
// import 'custom_datetime_widget.dart';
// import 'custom_input_area_widget.dart';
// import 'custom_input_widget.dart';
// import 'custom_label_widget.dart';
// import 'custom_level_widget.dart';
// import 'custom_radio_widget.dart';
// import 'custom_select_picture_widget.dart';
// import 'custom_select_widget.dart';
// import 'custom_signature_widget.dart';
// import 'custom_switch_widget.dart';
//
// class WidgetRender extends StatelessWidget {
//   final Map<String, dynamic> map;
//
//   const WidgetRender({Key? key, required this.map}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     switch (map['type']) {
//       case "text":
//         return CustomInputView(map: map);
//       case "textArea":
//         return CustomInputAreaWidget(map: map);
//       case "line":
//         return const Divider();
//       case "pager":
//         return const SizedBox();
//       case "title":
//         return CustomLabelWidget(map: map);
//       case "switch":
//         return CustomSwitchWidget(map: map);
//       case "checkBox":
//         return CustomCheckboxWidget(map: map);
//       case "date":
//         return CustomDateTimeWidget(map: map);
//       case "selectBox":
//         return CustomSelectBoxWidget(map: map);
//       case "radio":
//         return CustomRadioWidget(map: map);
//       case "picture":
//         return CustomSelectPicturesWidget(map: map);
//       case "level":
//         return CustomLevelWidget(map: map);
//       case "signature":
//         return CustomSignatureWidget(map: map);
//       case "dateRange":
//         return CustomDateRangeWidget(map: map);
//       default:
//         return Container(child: Text("未适配的控件===${map['type']}"));
//     }
//   }
// }
