import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form/form.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.black,),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Loading ",
                style: TextStyle(fontSize: 18),
              ),
              TextLoading(
                text: "...",
                textStyle: TextStyle(fontSize: 18),
              ),
            ],
          )
        ],
      ),
    );
  }
}
