// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// /// 评分控件
// class CustomLevelWidget extends StatefulWidget {
//   final Map<String, dynamic> map;
//
//   const CustomLevelWidget({Key? key, required this.map}) : super(key: key);
//
//   @override
//   createState() => _CustomLevelWidgetState();
// }
//
// class _CustomLevelWidgetState extends State<CustomLevelWidget> {
//   double levelValue = 0;
//
//   late StreamSubscription widgetChangeSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//
//     widgetChangeSubscription = eventBus.on<WidgetEvent>().listen((res) {
//       /// 监听控件变化
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//         visible: !widget.map['hidden'],
//         child: Container(
//             margin: EdgeInsets.only(bottom: 10.w),
//             decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(15.w)),
//             padding: EdgeInsets.all(15.w),
//             alignment: Alignment.center,
//             child: Row(children: [
//               SizedBox(width: 5.w),
//               Text("${widget.map['label']}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
//               Visibility(
//                   visible: widget.map['required'],
//                   child: Text("*", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.red))),
//               const Spacer(),
//               GFRating(
//                   onChanged: (value) {
//                     if (mounted)
//                       setState(() {
//                         levelValue = value;
//                       });
//                   },
//                   value: levelValue,
//                   itemCount: 5,
//                   size: 30.w,
//                   color: const Color(0xffFFD453),
//                   borderColor: const Color(0xffFFD453))
//             ])));
//   }
//
//   @override
//   void dispose() {
//     widgetChangeSubscription.cancel();
//     super.dispose();
//   }
// }
