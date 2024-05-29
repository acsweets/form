import 'package:flutter/material.dart';

import '../../bean/base_composes_model.dart';

abstract class IComposes extends StatefulWidget {
  final BaseComposesModel baseComposes;

  const IComposes({super.key, required this.baseComposes});

  @override
  State<IComposes> createState() => _IComposesState();
}

class _IComposesState extends State<IComposes> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class FormCompose extends StatefulWidget {
  final BaseComposesModel baseComposes;
  final List<Widget> children;

  const FormCompose({super.key, required this.baseComposes, this.children = const []});

  @override
  State<FormCompose> createState() => _FormComposeState();
}

class _FormComposeState extends State<FormCompose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.baseComposes.label),
      ),
      body: Column(
        children: widget.children,
      ),
    );
  }
}
