// import 'package:flutter/material.dart';
//
// import 'custom_select_detail.dart';
//
// /// 下拉框
// class CustomSelectBoxWidget extends StatefulWidget {
//   final Map<String, dynamic> map;
//
//   const CustomSelectBoxWidget({Key? key, required this.map}) : super(key: key);
//
//   @override
//   createState() => _CustomSelectBoxWidgetState();
// }
//
// class _CustomSelectBoxWidgetState extends State<CustomSelectBoxWidget> {
//   String content = '';
//
//   @override
//   void initState() {
//     super.initState();
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
//               if (mounted) setState(() {});
//               showCupertinoModalBottomSheet(
//                   context: context,
//                   builder: (_) => CustomSelectDetail(
//                       title: widget.map['label']!,
//                       data: widget.map["customDataSource"],
//                       placeholder: widget.map['placeholder']!)).then((value) {
//                 //单选多选分开处理
//                 //content = value["name"];
//                 setState(() {});
//                 Log.d('$value');
//               });
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
//     super.dispose();
//   }
// }
