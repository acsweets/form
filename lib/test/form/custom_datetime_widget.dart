// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// /// 日期、时间
// class CustomDateTimeWidget extends StatefulWidget {
//   final Map<String, dynamic> map;
//
//   const CustomDateTimeWidget({Key? key, required this.map}) : super(key: key);
//
//   @override
//   createState() => _CustomDateTimeWidgetState();
// }
//
// class _CustomDateTimeWidgetState extends State<CustomDateTimeWidget> {
//   String content = '';
//
//   DateTime selectTime = DateTime.now();
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
//               if (widget.map['mode'] == 'date') {
//                 showCustomDatePicker(context, selectTime, onConfirm: (value) {
//                   selectTime = value;
//                   content = DateUtil.formatDate(value, format: widget.map['format']);
//
//                   eventBus.fire(WidgetValueChangedEvent(widget.map['id'],
//                       value: value.millisecondsSinceEpoch, type: widget.map['type'], mode: widget.map['mode']));
//                 });
//               } else if (widget.map['mode'] == 'dateTime') {
//                 showCustomDateTimePicker(context, selectTime, onConfirm: (value) {
//                   selectTime = value;
//                   content = DateUtil.formatDate(value, format: widget.map['format']);
//
//                   eventBus.fire(WidgetValueChangedEvent(widget.map['id'],
//                       value: value.millisecondsSinceEpoch, type: widget.map['type'], mode: widget.map['mode']));
//                 });
//               } else if (widget.map['mode'] == 'year') {
//                 showCustomYearPicker(context, selectTime, onConfirm: (value) {
//                   selectTime = value;
//                   content = DateUtil.formatDate(value, format: "yyyy年");
//
//                   eventBus.fire(WidgetValueChangedEvent(widget.map['id'],
//                       value: value.year, type: widget.map['type'], mode: widget.map['mode']));
//                 }, minTime: DateTime(1940), maxTime: DateTime(2050));
//               } else if (widget.map['mode'] == 'month') {
//                 showCustomYearMonthPicker(context, selectTime, onConfirm: (value) {
//                   selectTime = value;
//                   content = DateUtil.formatDate(value, format: "yyyy年MM月");
//
//                   eventBus.fire(WidgetValueChangedEvent(widget.map['id'],
//                       value: "${value.year}-${value.month}", type: widget.map['type'], mode: widget.map['mode']));
//                 }, minTime: DateTime(1940), maxTime: DateTime(2050, 12));
//               }
//               if (mounted) setState(() {});
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
