import 'package:flutter/material.dart';

class GroupComponent extends StatefulWidget {
  final List<Widget> children;
  final String label;

  const GroupComponent({super.key, this.children = const [], required this.label});

  @override
  State<GroupComponent> createState() => _GroupComponentState();
}

class _GroupComponentState extends State<GroupComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 16, top: 12, bottom: 12),
              child: Text(
                "${widget.label}",
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              )),
          ...widget.children,
        ],
      ),
    );
  }
}
