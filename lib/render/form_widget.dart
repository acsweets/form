import 'package:flutter/material.dart';
import 'package:form/form.dart';

import '../parse/form_decode.dart';
import '../widgets/loading_widget.dart';

class FormWidget extends StatefulWidget {
  final String path;

  const FormWidget({super.key, required this.path});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> with Loader {
  Widget? _child;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.delayed(Duration(seconds: 2), () {
      parse(context, url: widget.path).then((value) {
        if (mounted && value != null) {
          //解析后吧值给child
          setState(() => _child = value);
        }
      });
    });
    //解析后得到能够渲染的Widget
  }

//根据解析出的表单
  @override
  Widget build(BuildContext context) {
    return _child ?? const LoadingWidget();
  }
}

