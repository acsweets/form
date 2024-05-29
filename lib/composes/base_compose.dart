import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'compose_state.dart';

///    {
//       "id": "",
//       "order": 0,
//       "type": "text",
//       "editMode": true,
//       "label": "数字输入框",
//       "placeholder": "请输入值",
//       "key": "",
//       "defaultValue": "",
//       "required": false,
//       "requiredMessage": "必填项",
//       "disabled": false,
//       "hidden": false,
//       "group": "",
//       "state": "default",
//       "cleanable": false,
//       "style": {
//         "width": "100%",
//         "height": "35px",
//         "color": "",
//         "styleMode": "floating"
//       },
//       "events": [],
//       "reg": false,
//       "regPattern": "",
//       "regMessage": "",
//       "mode": "number",
//       "valueChangeEvent": "blur",
//       "count": 0,
//       "min": 0,
//       "max": 0,
//       "isShowComponent": true,
//       "alisa": "age"
//     },
//组件的类型
enum ComposeType {
  text, //文本输入
  textArea, //描述输入
  line, // 线
  pager, //
  title,//输入标题组件
  selectBox,//选择框
  checkBox,//
  // switch,//开关
  date,//日期组件
  dateRange,
}
//抽象出组件所共有的部分
abstract class BaseCompose extends StatelessWidget {
  final String label;
  final bool? hidden;
  final bool required;

  const BaseCompose({super.key, required this.label, this.hidden = true, required this.required});

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Row(children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Visibility(
              visible: required,
              child: const Text("*", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red))),
          const SizedBox(width: 20),
          compose(context),
        ]));
    child = Visibility(visible: hidden!, child: child);

    return child;
  }

  Widget compose(BuildContext context);
}


