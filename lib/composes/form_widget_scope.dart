import 'package:flutter/material.dart';

import '../base_form/form_component.dart';

class FormRenderComponent extends StatefulWidget {
  final List<Widget> children;

  const FormRenderComponent({super.key, this.children = const []});

  @override
  State<FormRenderComponent> createState() => FormRenderComponentState();
}

class FormRenderComponentState extends State<FormRenderComponent> {
  late FormRenderComponentLogic logic;

  @override
  void initState() {
    logic = FormRenderComponentLogic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormComponent(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...widget.children,
                Button()
              ],
            ),
          )),
    );
  }
}

class FormRenderComponentScope extends InheritedNotifier<FormRenderComponentLogic> {
  const FormRenderComponentScope({super.key, required super.child});

  //notifier是InheritedNotifier 持有想要共享的内容 就是ComposeState
  static FormRenderComponentLogic of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FormRenderComponentScope>()!.notifier!;
  }

  static FormRenderComponentLogic read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<FormRenderComponentScope>()!.notifier!;
  }
}

class FormRenderComponentLogic extends ChangeNotifier {
  Map<String, dynamic> map = {};
  final formKey = GlobalKey<FormState>();

  void addParam(String key, dynamic value) {
    map[key] = value;
  }
}

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Form.of(context).save();
        // if (formKey.currentState!.validate()) {
        // logic.formKey.currentState!.save();
        // // 在这里进行表单提交操作 ,通过Key拿到状态类
        // logic.formKey.currentState!.reset();
        // FormRenderComponentScope.of(context).formKey;
        ///管理子组件的重建
        ///提交时拿到组件的key value;
        // }
      },
      child: Text('Submit'),
    );
  }
}
