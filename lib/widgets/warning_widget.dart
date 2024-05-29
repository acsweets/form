import 'package:flutter/material.dart';
import 'package:form/form.dart';

class WarningWidget extends StatefulWidget {
  final ComposeType? type;
  final String? message;

  const WarningWidget({super.key, this.type, this.message});

  @override
  State<WarningWidget> createState() => _WarningWidgetState();
}

class _WarningWidgetState extends State<WarningWidget> {
  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      children: [
        if (widget.type != null)
          Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(color: Colors.blue.withOpacity(0.6), borderRadius: BorderRadius.circular(10)),
              child: RichText(
                text: TextSpan(
                  text: "解析组件失败",
                  children: [
                    TextSpan(
                      text: " ${widget.type!.label} ",
                      style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const TextSpan(
                      text: "类型组件未适配,",
                    ),
                  ],
                ),
              )),
        if (widget.message != null) Text(" 解析失败，因为${widget.message}, ")
      ],
    );
    return Center(
      child: child,
    );
  }
}
