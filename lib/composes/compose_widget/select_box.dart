import 'package:flutter/material.dart';
class SelectBoxWidget extends StatefulWidget {
  const SelectBoxWidget({super.key});

  @override
  State<SelectBoxWidget> createState() => _SelectBoxWidgetState();
}

class _SelectBoxWidgetState extends State<SelectBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("SelectBox"),
    );
  }
}
