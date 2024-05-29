// import 'package:flutter/material.dart';
//
// class FormPage extends StatefulWidget {
//   const FormPage({Key? key}) : super(key: key);
//
//   @override
//   createState() => _FormPageState();
// }
//
// class _FormPageState extends State<FormPage> {
//   late FormModel model;
//
//   @override
//   void initState() {
//     super.initState();
//     model = FormModel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ProviderWidget<FormModel?>(
//         model: model,
//         onModelReady: (model) {
//           model!.initData();
//         },
//         builder: (BuildContext context, FormModel? model, Widget? child) {
//           return Scaffold(
//               backgroundColor: Provider.of<ThemeModel>(context).cardBgColor7,
//               appBar: AppBar(
//                   centerTitle: true,
//                   title: const Text("表单"),
//                   backgroundColor: Theme.of(context).scaffoldBackgroundColor),
//               body: SingleChildScrollView(
//                   padding: EdgeInsets.all(15.w),
//                   child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: model!.children)),
//               bottomNavigationBar: BottomNavigationBarBg(
//                   child: RadiusInkWellWidget(
//                       onPressed: () {},
//                       radius: 30.w,
//                       child: Container(
//                           alignment: Alignment.center,
//                           height: 50.w,
//                           child: Text('提交',
//                               style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700))))));
//         });
//   }
// }
