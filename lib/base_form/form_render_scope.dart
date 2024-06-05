import 'package:flutter/material.dart';

import 'form_render_logic.dart';

class FormRenderScope extends InheritedNotifier<FormRenderLogic> {
  const FormRenderScope({super.key, required super.child, super.notifier});

  //notifier是InheritedNotifier 持有想要共享的内容 就是ComposeState
  static FormRenderLogic of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FormRenderScope>()!.notifier!;
  }

  static FormRenderLogic read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<FormRenderScope>()!.notifier!;
  }
}