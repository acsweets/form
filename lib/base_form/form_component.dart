import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form/form.dart';
import '../utils/enum.dart';
import 'form_component.dart';
import 'form_component_scope.dart';
import 'form_field_component.dart';


///不能够继承吗？
class FormComponent extends StatefulWidget {
  /// 表单的小部件
  final Widget child;

  final bool? canPop;

  final PopInvokedCallback? onPopInvoked;

  /// 当其中一个表单字段更改时调用
  final VoidCallback? onChanged;

  /// 用于启用、禁用表单字段自动验证并更新其错误文本
  final FormValidationMode formValidationMode;

  const FormComponent({
    super.key,
    required this.child,
    this.canPop,
    this.onPopInvoked,
    this.onChanged,
    FormValidationMode? formValidationMode,
  }) : formValidationMode = formValidationMode ?? FormValidationMode.disabled;

  @override
  State<FormComponent> createState() => FormComponentState();


  static FormComponentState? maybeOf(BuildContext context) {
    final FormComponentScope? scope = context.dependOnInheritedWidgetOfExactType<FormComponentScope>();
    return scope?.formState;
  }
}

class FormComponentState extends State<FormComponent> {

  bool _hasInteractedByUser = false;



  int _generation = 0;

  @override
  Widget build(BuildContext context) {
    return FormComponentScope(
       this,
      _generation,
      child: widget.child,
    );
  }

  final Set<FormFieldComponentState<dynamic>> _fields = <FormFieldComponentState<dynamic>>{};

  // 当表单字段发生更改
  void _fieldDidChange() {
    widget.onChanged?.call();
    // _hasInteractedByUser = _fields.any((FormFieldComponentState<dynamic> field) => field._hasInteractedByUser.value);
    _forceRebuild();
  }

  /// 重建
  void _forceRebuild() {
    setState(() {
      ++_generation;
    });
  }

}
