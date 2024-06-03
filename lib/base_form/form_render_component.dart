import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form/entities/base_composes_model.dart';

import 'form_component.dart';

class FormRenderComponent extends StatefulWidget {
  final List<Widget> children;
  final BaseComposesModel component;

  const FormRenderComponent({super.key, this.children = const [], required this.component});

  @override
  State<FormRenderComponent> createState() => FormRenderComponentState();
}

class FormRenderComponentState extends State<FormRenderComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _title(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FormComponent(
          formValidationMode: FormValidationMode.auto,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...widget.children,
              ],
            ),
          )),
    );
  }

  PreferredSize _title() {
    double top = AppBarTheme.of(context).toolbarHeight ?? kToolbarHeight;
    return PreferredSize(
      preferredSize: Size(double.infinity, 180.w),
      child: Container(
        margin: EdgeInsets.only(top: top),
        height: 150.w,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bg1.png"), fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.component.label,
              style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w600),
            ),
            Text(
              widget.component.placeholder,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Button extends StatelessWidget {
//   const Button({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () {
//         FormComponent.maybeOf(context)!.save();
//       },
//       child: Text("1111"),
//     );
//   }
// }
