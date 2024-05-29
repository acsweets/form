import 'package:flutter/material.dart';

class TitleWidget extends StatefulWidget {
  const TitleWidget({super.key});

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {

  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("TitleWidget"),
        ],
      ),
    );
  }
}
