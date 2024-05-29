import 'package:flutter/material.dart';
class PagerWidget extends StatefulWidget {
  const PagerWidget({super.key});

  @override
  State<PagerWidget> createState() => _PagerWidgetState();
}

class _PagerWidgetState extends State<PagerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("PagerWidget"),
    );
  }
}
