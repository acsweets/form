// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// /// 单选组
// class CustomRadioWidget extends StatefulWidget {
//   final Map<String, dynamic> map;
//
//   const CustomRadioWidget({Key? key, required this.map}) : super(key: key);
//
//   @override
//   createState() => _CustomRadioWidgetState();
// }
//
// class _CustomRadioWidgetState extends State<CustomRadioWidget> {
//   int? groupValue;
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
//             padding: EdgeInsets.only(top: 15.w, left: 15.w, right: 15.w),
//             alignment: Alignment.center,
//             child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Row(children: [
//                 Text("${widget.map['label']}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
//                 Visibility(
//                     visible: widget.map['required'],
//                     child: Text("*", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.red)))
//               ]),
//               ListView.separated(
//                   itemBuilder: (_, index) {
//                     return RadioListTile<int?>(
//                         contentPadding: EdgeInsets.zero,
//                         title: Text(widget.map['dataSource'][index]['name'], style: TextStyle(fontSize: 14.sp)),
//                         onChanged: (value) {
//                           groupValue = value;
//                           setState(() {});
//                         },
//                         groupValue: groupValue,
//                         value: widget.map['dataSource'][index]['id']);
//                   },
//                   separatorBuilder: (_, index) {
//                     return const Divider(height: 0);
//                   },
//                   itemCount: widget.map['dataSource'].length,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   padding: EdgeInsets.zero)
//             ])));
//   }
//
//   @override
//   void dispose() {
//     widgetChangeSubscription.cancel();
//     super.dispose();
//   }
// }
