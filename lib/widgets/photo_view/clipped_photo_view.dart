// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';

// import '../../misc/colors.dart';

// class ClippedPhotoPage extends StatelessWidget {
//   const ClippedPhotoPage({
//     super.key,
//     required this.idForum,
//     required this.indexPhoto,
//   });

//   final int idForum;
//   final int indexPhoto;

//   @override
//   Widget build(BuildContext context) {
//     debugPrint("IdForum $idForum indexPhoto $indexPhoto");
//     return BlocProvider<DetailPrelovedCubit>(
//       create: (context) =>
//           DetailPrelovedCubit()..fetchDetailPreloved(idForum.toString()),
//       child: ClippedPhotoView(
//         initialIndex: indexPhoto,
//       ),
//     );
//   }
// }

// class ClippedPhotoView extends StatefulWidget {
//   const ClippedPhotoView({super.key, required this.initialIndex});

//   final int initialIndex;

//   @override
//   State<ClippedPhotoView> createState() => _ClippedPhotoViewState();
// }

// class _ClippedPhotoViewState extends State<ClippedPhotoView> {
//   bool isScale = false;
//   int zoom = 0;
//   int indexImage = 0;
//   late PageController pageController;
//   @override
//   void initState() {
//     super.initState();
//     indexImage = widget.initialIndex;
//     pageController = PageController(initialPage: indexImage);
//   }

//   void onPageChanged(int index) {
//     setState(() {
//       indexImage = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     debugPrint("currentIndex init $indexImage");
//     return BlocBuilder<DetailPrelovedCubit, DetailPrelovedState>(
//         builder: (context, st) {
//       return AnnotatedRegion(
//         value: SystemUiOverlayStyle.light,
//         child: SafeArea(
//             child: Scaffold(
//           body: Stack(
//             fit: StackFit.expand,
//             clipBehavior: Clip.none,
//             children: [
//               Positioned.fill(
//                 child: PhotoViewGallery.builder(
//                   scaleStateChangedCallback: (value) {
//                     setState(() {
//                       isScale = value.isScaleStateZooming;
//                       zoom = value.index;
//                     });
//                   },
//                   onPageChanged: onPageChanged,
//                   pageController: pageController,
//                   scrollPhysics: const BouncingScrollPhysics(),
//                   builder: (BuildContext context, int i) {
//                     debugPrint("currentIndex $indexImage");
//                     debugPrint(
//                         "Current Image :  ${st.detailPreloved!.forumMedia![indexImage].link}");

//                     return PhotoViewGalleryPageOptions(
//                       minScale: PhotoViewComputedScale.contained * 1,
//                       maxScale: PhotoViewComputedScale.covered * 3,
//                       onTapDown: (context, details, controllerValue) {
//                         setState(() {
//                           zoom = details.kind!.index;
//                         });
//                       },
//                       imageProvider: st.detailPreloved!.forumMedia!.isEmpty
//                           ? const AssetImage('assets/images/default/ava.jpg')
//                           : Image.network(
//                                   st.detailPreloved!.forumMedia![indexImage]
//                                           .link ??
//                                       "",
//                                   fit: BoxFit.contain)
//                               .image,
//                       initialScale: PhotoViewComputedScale.contained * 0.8,
//                       heroAttributes: PhotoViewHeroAttributes(
//                           tag: st.detailPreloved!.forumMedia![indexImage]
//                                   .forumId ??
//                               ""),
//                     );
//                   },
//                   itemCount: st.detailPreloved?.forumMedia?.length ?? 0,
//                   loadingBuilder: (context, event) => Center(
//                     child: SizedBox(
//                       width: 20.0,
//                       height: 20.0,
//                       child: CircularProgressIndicator(
//                         value: event == null
//                             ? 0
//                             : event.cumulativeBytesLoaded /
//                                 event.expectedTotalBytes!,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               isScale || zoom == 1
//                   ? Container()
//                   : Align(
//                       alignment: Alignment.topCenter,
//                       child: Container(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Text(
//                           "Gambar ${indexImage + 1}",
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 17.0,
//                             decoration: null,
//                           ),
//                         ),
//                       ),
//                     ),
//               isScale || zoom == 1
//                   ? Container()
//                   : Positioned(
//                       top: 15.0,
//                       left: 15.0,
//                       right: 15.0,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.greyColor.withOpacity(0.8),
//                             ),
//                             child: isScale || zoom == 1
//                                 ? Container()
//                                 : CupertinoNavigationBarBackButton(
//                                     color: AppColors.whiteColor,
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                   ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.greyColor.withOpacity(0.8),
//                             ),
//                             child: PopupMenuButton(
//                               color: AppColors.whiteColor,
//                               iconColor: Colors.white,
//                               iconSize: 20,
//                               itemBuilder: (BuildContext buildContext) {
//                                 return [
//                                   const PopupMenuItem(
//                                       value: "/save",
//                                       child: Text("Simpan Foto",
//                                           style: TextStyle(
//                                               color: AppColors.greyColor,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w600,
//                                               fontFamily: 'SF Pro'))),
//                                 ];
//                               },
//                               onSelected: (route) async {
//                                 if (route == "/save") {
//                                   // await DownloadHelper.downloadDoc(context: context, url: st.comment?.data.medias[indexImage].path ?? "");
//                                 }
//                               },
//                             ),
//                           )
//                         ],
//                       )),
//             ],
//           ),
//         )),
//       );
//     });
//   }
// }
