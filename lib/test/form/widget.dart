import 'dart:async';

import 'package:flutter/material.dart';
class TextFiled extends StatefulWidget {
  final Map<String, dynamic> map;

  const TextFiled({super.key, required this.map});

  @override
  State<TextFiled> createState() => _TextFiledState();
}

class _TextFiledState extends State<TextFiled> {
  late StreamSubscription widgetChangeSubscription;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    // widgetChangeSubscription = eventBus.on<WidgetEvent>().listen((res) {
    //   /// 监听控件变化
    // });

    controller = TextEditingController()
      ..addListener(() {
        setState(() {});
      })
      ..text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: !widget.map['hidden'],
        child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(15),
            alignment: Alignment.center,
            child: Row(children: [
              Text("${widget.map['label']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              Visibility(
                  visible: widget.map['required'],
                  child: const Text("*", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red))),
              const SizedBox(width: 20),
              Expanded(
                  child: TextField(
                      controller: controller,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      textAlign: TextAlign.end,
                      keyboardType: widget.map['mode'] == "number" || widget.map['mode'] == "price"
                          ? TextInputType.number
                          : widget.map['mode'] == "email"
                          ? TextInputType.emailAddress
                          : widget.map['mode'] == "contact-mobile"
                          ? TextInputType.phone
                          : widget.map['mode'] == "password"
                          ? TextInputType.visiblePassword
                          : TextInputType.text,
                      obscureText: widget.map['mode'] == "password",
                      decoration: InputDecoration(
                          hintText: widget.map['placeholder'] ?? '',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                          border: InputBorder.none),
                      onChanged: (value) {
                        // eventBus.fire(WidgetValueChangedEvent(widget.map['id'],
                        //     value: value, type: widget.map['type'], mode: widget.map['mode']));
                      }))
            ])));
  }

  @override
  void dispose() {
    controller.dispose();
    widgetChangeSubscription.cancel();
    super.dispose();
  }
}




