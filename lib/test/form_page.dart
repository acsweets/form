
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../bean/compose.dart';
import 'conmposes/compose_factory.dart';

class FromPage extends StatefulWidget {
  const FromPage({super.key});

  @override
  State<FromPage> createState() => _FromPageState();
}

class _FromPageState extends State<FromPage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  List<Compose> composeList = [];

  Future<void> _load() async {
    String content = await rootBundle.loadString("assets/form.json");
    Map<String, dynamic> formAsMap = json.decode(content);
    composeList = (formAsMap["children"] as List).map(Compose.fromMap).toList();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title:Text("表单",) ),
      body: Column(
        children: [
          ...List.generate(composeList.length, (index) {
            return Container(
              child: composes[composeList[index].type],
            );
          })
        ],
      ),
    );
  }
}
