import 'package:flutter/material.dart';
import 'package:form/bean/base_composes_model.dart';

class TextWidget extends StatefulWidget {
  final BaseComposesModel composes;

  const TextWidget({super.key, required this.composes});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    Widget child = Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Row(children: [
          Text(widget.composes.label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Visibility(
              visible: widget.composes.validateConfig.required ?? false,
              child: const Text("*", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red))),
          const SizedBox(width: 20),
          Expanded(
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                hintText: widget.composes.placeholder,
              ),
            ),
          ),
        ]));
    return child;
  }
}
