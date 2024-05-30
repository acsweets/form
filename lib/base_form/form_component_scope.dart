import 'package:flutter/material.dart';

import 'form_component.dart';


class FormComponentScope extends InheritedWidget {
  const FormComponentScope(this.formState, this.generation, {
    super.key,
    required super.child,
  }) ;

  final FormComponentState formState;

  /// 递增时，重建表单。
  final int generation;

  /// 与此小部件关联的[Form]。
  FormComponent get formComponent=> formState.widget;

  ///[_generation]值改变就更新通知
  @override
  bool updateShouldNotify(FormComponentScope old) => generation != old.generation;

}
