// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// /// 开关
// class CustomSwitchWidget extends StatefulWidget {
//   final Map<String, dynamic> map;
//
//   const CustomSwitchWidget({Key? key, required this.map}) : super(key: key);
//
//   @override
//   createState() => _CustomSwitchWidgetState();
// }
//
// class _CustomSwitchWidgetState extends State<CustomSwitchWidget> {
//   bool value = false;
//   late StreamSubscription widgetChangeSubscription;
//
//   @override
//   void initState() {
//     super.initState();
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
//               CupertinoSwitch(
//                   value: value,
//                   onChanged: (bool value) {
//                     if (mounted) {
//                       eventBus.fire(WidgetValueChangedEvent(widget.map['id'], value: value, type: widget.map['type']));
//                       setState(() {
//                         this.value = value;
//                       });
//                     }
//                   },
//                   activeColor: Theme.of(context).primaryColor)
//             ])));
//   }
//
//   @override
//   void dispose() {
//     widgetChangeSubscription.cancel();
//     super.dispose();
//   }
// }
