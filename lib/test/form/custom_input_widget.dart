// import 'dart:async';
//
// import 'package:bct/index.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// /// 单行输入框
// class CustomInputView extends StatefulWidget {
//   final Map<String, dynamic> map;
//
//   const CustomInputView({Key? key, required this.map}) : super(key: key);
//
//   @override
//   createState() => _CustomInputViewState();
// }
//
// class _CustomInputViewState extends State<CustomInputView> {
//   late StreamSubscription widgetChangeSubscription;
//   late TextEditingController controller;
//
//   @override
//   void initState() {
//     super.initState();
//
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
//             child: Row(children: [
//               Text("${widget.map['label']}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
//               Visibility(
//                   visible: widget.map['required'],
//                   child: Text("*", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.red))),
//               SizedBox(width: 20.w),
//               Expanded(
//                   child: TextField(
//                       controller: controller,
//                       style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w500,
//                           color: Provider.of<ThemeModel>(context).textColor),
//                       textAlign: TextAlign.end,
//                       keyboardType: widget.map['mode'] == "number" || widget.map['mode'] == "price"
//                           ? TextInputType.number
//                           : widget.map['mode'] == "email"
//                               ? TextInputType.emailAddress
//                               : widget.map['mode'] == "contact-mobile"
//                                   ? TextInputType.phone
//                                   : widget.map['mode'] == "password"
//                                       ? TextInputType.visiblePassword
//                                       : TextInputType.text,
//                       obscureText: widget.map['mode'] == "password",
//                       inputFormatters: widget.map['mode'] == "contact-mobile"
//                           ? [phoneInputFormatter(), LengthLimitingTextInputFormatter(13)]
//                           : widget.map['mode'] == "id"
//                               ? [LengthLimitingTextInputFormatter(18)]
//                               : widget.map['mode'] == "price"
//                                   ? [priceInputFormatter()]
//                                   : [],
//                       decoration: InputDecoration(
//                           hintText: widget.map['placeholder'] ?? '',
//                           hintStyle: TextStyle(color: ColorUtil.color_999999, fontSize: 16.sp),
//                           border: InputBorder.none),
//                       onChanged: (value) {
//                         eventBus.fire(WidgetValueChangedEvent(widget.map['id'],
//                             value: value, type: widget.map['type'], mode: widget.map['mode']));
//                       }))
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
