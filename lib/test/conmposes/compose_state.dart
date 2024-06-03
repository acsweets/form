import 'package:flutter/cupertino.dart';


//怎么拿到组件内部的事件，通过steam 或者回调给传出去。
//表单状态  组件的内部状态  组件数据源
class ComposeState with ChangeNotifier {
  TextEditingController contentController = TextEditingController();
}

class ComposeScope extends InheritedNotifier<ComposeState> {
  const ComposeScope({super.key, required super.child, super.notifier});

  //notifier是InheritedNotifier 持有想要共享的内容 就是ComposeState
  static ComposeState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ComposeScope>()!.notifier!;
  }

  static ComposeState read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<ComposeScope>()!.notifier!;
  }

  static ComposeScope get(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ComposeScope>()!;
  }
}
