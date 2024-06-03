import 'package:flutter/material.dart';
import 'form_render_component_logic.dart';

class FormRenderComponentScope extends InheritedNotifier<FormRenderComponentLogic> {
  const FormRenderComponentScope({super.key, required super.child, super.notifier});

  //notifier是InheritedNotifier 持有想要共享的内容 就是ComposeState
  static FormRenderComponentLogic of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FormRenderComponentScope>()!.notifier!;
  }

  static FormRenderComponentLogic read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<FormRenderComponentScope>()!.notifier!;
  }
}