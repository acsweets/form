// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// /// 多选控件
// class CustomCheckboxWidget extends StatefulWidget {
//   final Map<String, dynamic> map;
//
//   const CustomCheckboxWidget({Key? key, required this.map}) : super(key: key);
//
//   @override
//   createState() => _CustomCheckboxWidgetState();
// }
//
// class _CustomCheckboxWidgetState extends State<CustomCheckboxWidget> {
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
//                     return CheckboxListTile(
//                         contentPadding: EdgeInsets.zero,
//                         value: widget.map['dataSource'][index]['selected'],
//                         onChanged: (value) {
//                           widget.map['dataSource'][index]['selected'] = value;
//                           setState(() {});
//                         },
//                         title: Text(widget.map['dataSource'][index]['name'], style: TextStyle(fontSize: 14.sp)));
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
