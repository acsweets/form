import 'package:flutter/material.dart';
class DateWidget extends StatefulWidget {
  const DateWidget({super.key});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Date"),
    );
  }
}
