import 'package:flutter/cupertino.dart';

//数据源的类型
enum DataSourceType {
  load, //加载远程数据源 请求加载即可
  lookup, //关联数据源,指a数据源的选项更改 会影响b的数据源更改 或者说 数据源是由另一个选项控制的
  normal, // 常量 不变的值
  reference, //是指不在数据源内 但是在各种上下文的一些变量
}
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
