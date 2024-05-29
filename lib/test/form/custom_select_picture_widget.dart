// import 'dart:async';
//
// import 'package:bct/index.dart';
// import 'package:flutter/material.dart';
//
// /// 图片选择
// class CustomSelectPicturesWidget extends StatefulWidget {
//   final Map<String, dynamic> map;
//
//   const CustomSelectPicturesWidget({Key? key, required this.map}) : super(key: key);
//
//   @override
//   createState() => _CustomSelectPicturesWidgetState();
// }
//
// class _CustomSelectPicturesWidgetState extends State<CustomSelectPicturesWidget> {
//   List<AssetEntity> imageList = [];
//   late int maxImages;
//
//   List<ResourceBean> pictures = [];
//   late StreamSubscription widgetChangeSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//
//     widgetChangeSubscription = eventBus.on<WidgetEvent>().listen((res) {
//       /// 监听控件变化
//     });
//
//     maxImages = widget.map['count'] ?? 1;
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
//                     child: Text("*", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.red)))
//               ]),
//               SizedBox(height: 15.w),
//               Wrap(
//                   spacing: 10.w,
//                   runSpacing: 10.w,
//                   children:
//                       List.generate(imageList.length < maxImages ? imageList.length + 1 : imageList.length, (index) {
//                     if (index == imageList.length) {
//                       return GFBorder(
//                           padding: EdgeInsets.zero,
//                           type: GFBorderType.rRect,
//                           dashedLine: const <double>[6, 3],
//                           radius: const Radius.circular(10),
//                           color: const Color(0xFFD2D2D2),
//                           child: RadiusInkWellWidget(
//                               onPressed: () {
//                                 DeviceUtils.hideKeyboard(context);
//                                 pickImage(context);
//                               },
//                               radius: 10,
//                               color: Theme.of(context).cardColor,
//                               child: SizedBox(
//                                   width: (1.sw - 80.w) / 3,
//                                   height: (1.sw - 80.w) / 3,
//                                   child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//                                     Icon(IconFont.picture_add, size: 22.w, color: const Color(0xffaaaaaa)),
//                                     SizedBox(height: 10.w),
//                                     Text('${S.current.communityPagePicture}(${imageList.length}/$maxImages)',
//                                         style: TextStyle(color: const Color(0xffaaaaaa), fontSize: 16.sp))
//                                   ]))));
//                     }
//                     return DeleteIconWidget(
//                         width: (1.sw - 80.w) / 3,
//                         height: (1.sw - 80.w) / 3,
//                         onDelete: () => deleteImage(index),
//                         child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10.w),
//                             child: Stack(children: [
//                               Image(
//                                   image: AssetEntityImageProvider(imageList[index], isOriginal: false),
//                                   fit: BoxFit.cover,
//                                   width: double.infinity,
//                                   height: double.infinity),
//                               Positioned(
//                                   bottom: 0,
//                                   right: 0,
//                                   child: pictures
//                                           .any((element) => element.isUpload && element.fileId == imageList[index].id)
//                                       ? Container(
//                                           width: 24.r,
//                                           height: 24.r,
//                                           child: Icon(Icons.check, color: Colors.white, size: 12.r),
//                                           decoration: BoxDecoration(
//                                               color: Colors.green,
//                                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10.w))))
//                                       : const SizedBox())
//                             ])));
//                   }))
//             ])));
//   }
//
//   // 根据索引删除图片
//   void deleteImage(int index) {
//     imageList.removeAt(index);
//     if (mounted) setState(() {});
//   }
//
//   /// 选择图片
//   Future<void> pickImage(BuildContext context) async {
//     List<AssetEntity> resultList = [];
//     try {
//       await AssetPicker.pickAssets(context,
//               pickerConfig: AssetPickerConfig(
//                   maxAssets: maxImages,
//                   requestType: RequestType.image,
//                   themeColor: Theme.of(context).primaryColor,
//                   selectedAssets: imageList))
//           .then((value) {
//         if (value != null) resultList = value;
//       });
//     } on Exception catch (e) {
//       Log.d('选择图片报错：${e.toString()}');
//     }
//     imageList = resultList;
//     if (mounted) setState(() {});
//
//     for (var image in imageList) {
//       if (pictures.every((picture) => picture.fileId == image.id && picture.isUpload)) {
//       } else {
//         String fileId = StringUtil.newId();
//         await Aliyun().upload(Keys.PICTURE, fileId, (await image.originFile)!.path,
//             onProgress: (ProgressResponse progress) {
//           Log.d("upload==>${progress.id!}==>${progress.value}");
//         }, onComplete: (UploadResponse resp) async {
//           Log.d("upload picture complete==>${resp.fileKey!}&==${resp.fileBucket!}");
//           Log.d('图片上传完成');
//           if (resp.success!) {
//             pictures.add(ResourceBean(
//                 ossType: OssType.ALIYUN_OSS,
//                 bucket: resp.fileBucket,
//                 contentType: FileContentType.IMAGE,
//                 uri: resp.fileKey,
//                 title: FileUtil.getFileNameByPath((await image.originFile)!.path),
//                 id: resp.fileId,
//                 fileId: image.id,
//                 isUpload: true));
//             if (mounted) setState(() {});
//           } else {
//             Log.error("${resp.message}", action: "onUpload", eventName: Keys.AUDIO);
//             showToast(text: '上传失败！');
//           }
//         });
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     widgetChangeSubscription.cancel();
//     super.dispose();
//   }
// }
