import 'dart:async';

import 'package:flutter/material.dart';

///文字依次出现 ,动画默认重复
class TextLoading extends StatefulWidget {
  final String text;
  final Duration animationDuration;
  final TextStyle? textStyle;

  const TextLoading({
    super.key,
    required this.text,
    this.textStyle,
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  State<TextLoading> createState() => _TextLoadingState();
}

class _TextLoadingState extends State<TextLoading> with SingleTickerProviderStateMixin {
  late ValueNotifier<String> textValue;
  int currentIndex = 0;

  late Timer timer;

  String get currentText => widget.text.substring(0, currentIndex);

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      textValueChanged();
    });
    textValue = ValueNotifier<String>("")
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = widget.textStyle ?? const TextStyle();

    return Text(textValue.value, style: textStyle);
  }

  void textValueChanged() {
    if (currentIndex >= widget.text.length) {
      currentIndex = 0;
    } else {
      currentIndex += 1;
      textValue.value = currentText;
    }
  }

  @override
  void dispose() {
    textValue.dispose();
    timer.cancel();
    super.dispose();
  }
}
