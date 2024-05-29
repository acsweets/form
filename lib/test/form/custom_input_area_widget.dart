// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// /// 多行输入框
// class CustomInputAreaWidget extends StatefulWidget {
//   final Map<String, dynamic> map;
//
//   const CustomInputAreaWidget({Key? key, required this.map}) : super(key: key);
//
//   @override
//   createState() => _CustomInputAreaWidgetState();
// }
//
// class _CustomInputAreaWidgetState extends State<CustomInputAreaWidget> {
//   late StreamSubscription widgetChangeSubscription;
//   late TextEditingController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     widgetChangeSubscription = eventBus.on<WidgetEvent>().listen((res) {
//       /// 监听控件变化
//     });
//
//     controller = TextEditingController()
//       ..addListener(() {
//         setState(() {});
//       })
//       ..text = "";
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
//             child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Row(children: [
//                 Text("${widget.map['label']}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
//                 Visibility(
//                     visible: widget.map['required'],
//                     child:
//                         Text("*", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.red))),
//               ]),
//               TextField(
//                   controller: controller,
//                   maxLines: 200,
//                   minLines: 3,
//                   keyboardType: TextInputType.multiline,
//                   style: TextStyle(
//                       fontSize: 16.sp, fontWeight: FontWeight.w500, color: Provider.of<ThemeModel>(context).textColor),
//                   decoration: InputDecoration(
//                       hintText: widget.map['placeholder'] ?? '',
//                       hintStyle: TextStyle(color: ColorUtil.color_999999, fontSize: 16.sp),
//                       border: InputBorder.none),
//                   onChanged: (value) {
//                     eventBus.fire(WidgetValueChangedEvent(widget.map['id'],
//                         value: value, type: widget.map['type'], mode: widget.map['mode']));
//                   })
//             ])));
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     widgetChangeSubscription.cancel();
//     super.dispose();
//   }
// }
