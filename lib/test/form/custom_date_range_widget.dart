// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// /// 日期区间
// class CustomDateRangeWidget extends StatefulWidget {
//   final Map<String, dynamic> map;
//
//   const CustomDateRangeWidget({Key? key, required this.map}) : super(key: key);
//
//   @override
//   createState() => _CustomDateRangeWidgetState();
// }
//
// class _CustomDateRangeWidgetState extends State<CustomDateRangeWidget> {
//   String content = '';
//
//   DateTime? startTime;
//   DateTime? endTime;
//
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
//         child: GestureDetector(
//             behavior: HitTestBehavior.opaque,
//             onTap: () {
//               FocusScope.of(context).requestFocus(FocusNode());
//               showCupertinoModalBottomSheet(
//                   context: context,
//                   builder: (_) {
//                     return RangeTimeView(
//                         onPressed: (DateTime startTime, DateTime endTime) {
//                           this.startTime = startTime;
//                           this.endTime = endTime;
//                           content =
//                               "${DateUtil.formatDate(startTime, format: widget.map['format'])} ~ ${DateUtil.formatDate(endTime, format: widget.map['format'])}";
//                           setState(() {});
//                         },
//                         startTime: startTime,
//                         endTime: endTime);
//                   });
//             },
//             child: Container(
//                 margin: EdgeInsets.only(bottom: 10.w),
//                 decoration:
//                     BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(15.w)),
//                 padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
//                 alignment: Alignment.center,
//                 child: Row(children: [
//                   Text("${widget.map['label']}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
//                   Visibility(
//                       visible: widget.map['required'],
//                       child:
//                           Text("*", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.red))),
//                   SizedBox(width: 20.w),
//                   Expanded(
//                       child: Text(StringUtil.isEmpty(content) ? widget.map['placeholder'] ?? '' : content,
//                           textAlign: TextAlign.end,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                               color: StringUtil.isEmpty(content)
//                                   ? ColorUtil.color_999999
//                                   : Provider.of<ThemeModel>(context).textColor,
//                               fontSize: 16.sp,
//                               fontWeight: StringUtil.isEmpty(content) ? FontWeight.normal : FontWeight.w500))),
//                   Icon(Icons.keyboard_arrow_right, color: Theme.of(context).primaryColor)
//                 ]))));
//   }
//
//   @override
//   void dispose() {
//     widgetChangeSubscription.cancel();
//     super.dispose();
//   }
// }
