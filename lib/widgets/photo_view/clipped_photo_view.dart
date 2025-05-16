import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../misc/colors.dart';
import '../../misc/download_manager.dart';
import '../../misc/theme.dart';
import '../../modules/forum_detail/cubit/forum_detail_cubit.dart';

class ClippedPhotoPage extends StatelessWidget {
  const ClippedPhotoPage({
    super.key,
    required this.idForum,
    required this.indexPhoto,
  });

  final int idForum;
  final int indexPhoto;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForumDetailCubit>(
      create: (context) =>
          ForumDetailCubit()..fetchForumDetail(idForum.toString()),
      child: ClippedPhotoView(
        initialIndex: indexPhoto,
      ),
    );
  }
}

class ClippedPhotoView extends StatefulWidget {
  const ClippedPhotoView({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  State<ClippedPhotoView> createState() => _ClippedPhotoViewState();
}

class _ClippedPhotoViewState extends State<ClippedPhotoView> {
  bool isScale = false;
  int zoom = 0;
  int indexImage = 0;
  PageController? pageController;
  @override
  void initState() {
    super.initState();
    indexImage = widget.initialIndex;
  }

  void onPageChanged(int index) {
    setState(() {
      indexImage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForumDetailCubit, ForumDetailState>(
        builder: (context, st) {
      final images = st.detailForum?.forumMedia ?? [];
      if (images.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      pageController ??= PageController(initialPage: widget.initialIndex);
      return AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                PhotoViewGallery.builder(
                  pageController: pageController,
                  itemCount: images.length,
                  onPageChanged: onPageChanged,
                  scaleStateChangedCallback: (state) {
                    setState(() {
                      isScale = state == PhotoViewScaleState.zoomedIn ||
                          state == PhotoViewScaleState.zoomedOut;
                    });
                  },
                  builder: (context, index) {
                    final image = images[index];
                    return PhotoViewGalleryPageOptions(
                      minScale: PhotoViewComputedScale.contained * 1,
                      maxScale: PhotoViewComputedScale.covered * 3,
                      imageProvider: image.link!.isEmpty
                          ? const AssetImage(avatarDefault)
                          : Image.network(image.link!, fit: BoxFit.contain)
                              .image,
                      heroAttributes:
                          PhotoViewHeroAttributes(tag: image.forumId ?? ""),
                    );
                  },
                ),
                if (!isScale) ...[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Gambar ${indexImage + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          decoration: null,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 15.0,
                      left: 15.0,
                      right: 15.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.greyColor.withOpacity(0.8),
                            ),
                            child: isScale || zoom == 1
                                ? Container()
                                : CupertinoNavigationBarBackButton(
                                    color: AppColors.whiteColor,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.greyColor.withOpacity(0.8),
                            ),
                            child: PopupMenuButton(
                              color: AppColors.whiteColor,
                              iconColor: Colors.white,
                              iconSize: 20,
                              itemBuilder: (BuildContext buildContext) {
                                return [
                                  const PopupMenuItem(
                                      value: "/save",
                                      child: Text("Simpan Foto",
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ))),
                                ];
                              },
                              onSelected: (route) async {
                                if (route == "/save") {
                                  await DownloadHelper.downloadDoc(
                                      context: context,
                                      url: st.detailForum
                                              ?.forumMedia![indexImage].link ??
                                          "");
                                }
                              },
                            ),
                          )
                        ],
                      )),
                ]
              ],
            ),
          ),
        ),
      );
    });
  }
}
