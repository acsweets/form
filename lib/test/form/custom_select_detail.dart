// import 'package:flutter/material.dart';
//
// class CustomSelectDetail extends StatefulWidget {
//   final String? title;
//   final String? placeholder;
//   final List<dynamic> data;
//   final bool isSimple;
//
//   const CustomSelectDetail({Key? key, this.title, this.placeholder, required this.data, this.isSimple = false})
//       : super(key: key);
//
//   @override
//   createState() => _CustomSelectDetailState();
// }
//
// class _CustomSelectDetailState extends State<CustomSelectDetail> {
//   List<CustomDtaSourceBean?> items = [];
//
//   @override
//   void initState() {
//     super.initState();
//     items = (widget.data).map((e) => CustomDtaSourceBean.fromMap(e)).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         child: Container(
//             height: .5.sh,
//             color: Provider.of<ThemeModel>(context).cardBgColor7,
//             child: Column(children: [
//               Container(
//                   color: Theme.of(context).scaffoldBackgroundColor,
//                   height: kToolbarHeight,
//                   alignment: Alignment.center,
//                   child: Text('${widget.title}', style: Theme.of(context).textTheme.titleLarge)),
//               Expanded(
//                   child: ListView.separated(
//                       padding: EdgeInsets.zero,
//                       itemBuilder: (_, index) =>
//                           widget.isSimple ? _listSimpleItem(items[index]!) : _listMultipleChoiceItem(items[index]!),
//                       itemCount: items.length,
//                       separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10.w))),
//               BottomNavigationBarBg(
//                   child: widget.isSimple
//                       ? const SizedBox()
//                       : RadiusInkWellWidget(
//                           onPressed: () {
//                             List<CustomDtaSourceBean?> _items =
//                                 items.where((element) => element?.selected == true).toList();
//                             List<dynamic> _data = _items.map((e) => e?.toJson()).toList();
//                             Navigator.pop(context, _data);
//                           },
//                           radius: 30.w,
//                           child: Container(
//                               alignment: Alignment.center,
//                               height: 45.w,
//                               child: Text('确认',
//                                   style:
//                                       TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)))))
//             ])));
//   }
//
//   Widget _listSimpleItem(CustomDtaSourceBean item) {
//     return GestureDetector(
//         onTap: () {
//           Navigator.pop(context, item.toJson());
//         },
//         child: Container(
//             margin: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
//             padding: EdgeInsets.all(20.w),
//             decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10.w)),
//             child: Text("${item.name}", style: TextStyle(fontSize: 16.sp))));
//   }
//
//   Widget _listMultipleChoiceItem(CustomDtaSourceBean item) {
//     return Container(
//         margin: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
//         padding: EdgeInsets.all(5.w),
//         decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10.w)),
//         child: CheckboxListTile(
//             title: Text("${item.name}", style: TextStyle(fontSize: 16.sp)),
//             value: item.selected,
//             onChanged: (value) {
//               setState(() {
//                 item.selected = value!;
//               });
//             }));
//   }
// }
//
// class CustomDtaSourceBean {
//   String? id;
//   String? name;
//   int? seq;
//   bool selected;
//
//   CustomDtaSourceBean({this.name, this.id, this.seq, this.selected = false});
//
//   static CustomDtaSourceBean? fromMap(Map<String, dynamic>? map) {
//     if (map == null) return null;
//     CustomDtaSourceBean customDtaSourceBean = CustomDtaSourceBean();
//
//     customDtaSourceBean.id = map["id"];
//     customDtaSourceBean.name = map["name"];
//     customDtaSourceBean.seq = map["seq"];
//     return customDtaSourceBean;
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "seq": seq,
//       };
// }
