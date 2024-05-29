import 'package:flutter/material.dart';

import '../composes/base_compose.dart';

class DynamicBuilder {
  final List<BaseCompose> components;

  DynamicBuilder(
    this.components,
  );

  Widget builder() {
    return Container();
  }
}
