import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form/render/form_widget.dart';
import 'package:form/utils/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, widget) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeData,
          darkTheme: darkThemeData,
          themeMode: ThemeMode.system,
          home: FormWidget(
            path: "assets/form1.json",
          ),
        );
      },
    );
  }
}
