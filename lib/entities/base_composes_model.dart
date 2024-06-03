import 'package:flutter/cupertino.dart';

import 'package:form/form.dart';



class BaseComposesModel {
  ///默认值
  dynamic defaultValue;

  ///别名
  String? alias;

  ///组件子节点
  List<BaseComposesModel>? children;

  ///组件类型
  ComposeType composeType;

  ///组件ID
  String id;

  ///提交表单的关键字
  String key;

  ///提交表单的值 [用户填写的值]
  dynamic value;

  ///展示组件的标题
  String label;

  ///未填写时的提示文本
  String placeholder;

  ///组件是否只读模式
  bool readOnly;

  ///禁用填写状态
  bool disabled;

  ///组件隐藏不渲染
  bool hidden;
  ComposeStyle styleConfig;
  ComposeValueRule validateConfig;
  dynamic extraConfig;

  BaseComposesModel(
      {this.defaultValue,
      this.alias,
      this.children,
      required this.composeType,
      required this.id,
      required this.key,
      this.value,
      required this.label,
      required this.placeholder,
      required this.readOnly,
      required this.disabled,
      required this.hidden,
      required this.styleConfig,
      required this.validateConfig,
      this.extraConfig});

  factory BaseComposesModel.formMap(Map map) {
    return BaseComposesModel(
      defaultValue: map["defaultValue"],
      alias: map["alias"],
      children:
          map["children"] == null ? [] : (map["children"] as List).map((e) => BaseComposesModel.formMap(e)).toList(),
      composeType: EnumUtils.stringToEnum(ComposeType.values, map["type"]) ?? ComposeType.unadapted,
      id: map["id"],
      key: map["key"],
      value: map["value"],
      label: map["label"],
      placeholder: map["placeholder"],
      readOnly: map["readonly"],
      disabled: map["disabled"],
      hidden: map["hidden"],
      styleConfig: ComposeStyle.formMap(map["styleConfig"]),
      validateConfig: ComposeValueRule.formMap(map["validateConfig"]),
      extraConfig: map["extraConfig"],
    );
  }
}

///组件风格
class ComposeStyle {
  String? width;
  String? height;
  AlignType? align;

  ComposeStyle({this.width, this.height, this.align});

  factory ComposeStyle.formMap(Map<String, dynamic> map) {
    return ComposeStyle(
        width: map["width"], height: map["height"], align: EnumUtils.stringToEnum(AlignType.values, map["align"]));
  }
}

///组件规则
class ComposeValueRule {
  ///是否必传
  bool? required;

  ///必传提示信息
  String? requiredMessage;

  ///是否启用正则校验
  bool? reg;

  ///正则
  String? regPattern;

  ///正则校验信息
  String? regMessage;

  ComposeValueRule({
    this.required,
    this.requiredMessage,
    this.reg,
    this.regPattern,
    this.regMessage,
  });

  factory ComposeValueRule.formMap(Map<String, dynamic> map) {
    return ComposeValueRule(
      required: map["required"],
      requiredMessage: map["requiredMessage"],
      reg: map["reg"],
      regPattern: map["regPattern"],
      regMessage: map["regMessage"],
    );
  }
}


