// import 'dart:async';
// import 'dart:typed_data';
//
// import 'package:bct/index.dart';
// import 'package:flutter/material.dart';
// import 'package:signature/signature.dart';
//
// /// 手写签名
// class CustomSignatureWidget extends StatefulWidget {
//   final Map<String, dynamic> map;
//
//   const CustomSignatureWidget({Key? key, required this.map}) : super(key: key);
//
//   @override
//   createState() => _CustomSignatureWidgetState();
// }
//
// class _CustomSignatureWidgetState extends State<CustomSignatureWidget> {
//   late SignatureController _controller;
//   late StreamSubscription widgetChangeSubscription;
//
//   Uint8List? pngBytes;
//
//   @override
//   void initState() {
//     super.initState();
//
//     widgetChangeSubscription = eventBus.on<WidgetEvent>().listen((res) {
//       /// 监听控件变化
//     });
//
//     _controller = SignatureController(penStrokeWidth: 3, penColor: Colors.black, exportBackgroundColor: Colors.blue);
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
//             child: Column(children: [
//               Row(children: [
//                 Text("${widget.map['label']}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
//                 Visibility(
//                     visible: widget.map['required'],
//                     child:
//                         Text("*", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.red))),
//               ]),
//               SizedBox(height: 15.w),
//               pngBytes == null
//                   ? Signature(
//                       controller: _controller, width: double.infinity, height: 250.w, backgroundColor: Colors.white)
//                   : const SizedBox.shrink(),
//               pngBytes != null
//                   ? Image.memory(pngBytes!, width: double.infinity, height: 250.w)
//                   : const SizedBox.shrink(),
//               Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                 TextButton(
//                     onPressed: () {
//                       _controller.clear();
//                       pngBytes = null;
//                       if (mounted) setState(() {});
//                     },
//                     child: const Text("重签")),
//                 TextButton(
//                     onPressed: () async {
//                       if (_controller.isNotEmpty && mounted) {
//                         pngBytes = await _controller.toPngBytes();
//                         setState(() {});
//                       }
//                     },
//                     child: const Text("确认"))
//               ])
//             ])));
//   }
//
//   @override
//   void dispose() {
//     widgetChangeSubscription.cancel();
//     _controller.dispose();
//     super.dispose();
//   }
// }
