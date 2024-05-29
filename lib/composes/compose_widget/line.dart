import 'package:flutter/material.dart';
class LineWidget extends StatefulWidget {
  const LineWidget({super.key});

  @override
  State<LineWidget> createState() => _LineWidgetState();
}

class _LineWidgetState extends State<LineWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Line"),
    );
  }
}
