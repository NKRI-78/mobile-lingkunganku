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
    debugPrint("IdForum $idForum indexPhoto $indexPhoto");
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
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    indexImage = widget.initialIndex;
    pageController = PageController(initialPage: indexImage);
  }

  void onPageChanged(int index) {
    setState(() {
      indexImage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("currentIndex init $indexImage");
    return BlocBuilder<ForumDetailCubit, ForumDetailState>(
        builder: (context, st) {
      return AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
            child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: PhotoViewGallery.builder(
                  scaleStateChangedCallback: (value) {
                    setState(() {
                      isScale = value.isScaleStateZooming;
                      zoom = value.index;
                    });
                  },
                  onPageChanged: onPageChanged,
                  pageController: pageController,
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int i) {
                    debugPrint("currentIndex $indexImage");
                    debugPrint(
                        "Current Image :  ${st.detailForum!.forumMedia![indexImage].link}");

                    return PhotoViewGalleryPageOptions(
                      minScale: PhotoViewComputedScale.contained * 1,
                      maxScale: PhotoViewComputedScale.covered * 3,
                      onTapDown: (context, details, controllerValue) {
                        setState(() {
                          zoom = details.kind!.index;
                        });
                      },
                      imageProvider: st.detailForum!.forumMedia!.isEmpty
                          ? const AssetImage(avatarDefault)
                          : Image.network(
                                  st.detailForum!.forumMedia![indexImage]
                                          .link ??
                                      "",
                                  fit: BoxFit.contain)
                              .image,
                      initialScale: PhotoViewComputedScale.contained * 0.8,
                      heroAttributes: PhotoViewHeroAttributes(
                          tag:
                              st.detailForum!.forumMedia![indexImage].forumId ??
                                  ""),
                    );
                  },
                  itemCount: st.detailForum?.forumMedia?.length ?? 0,
                  loadingBuilder: (context, event) => Center(
                    child: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        value: event == null
                            ? 0
                            : event.cumulativeBytesLoaded /
                                event.expectedTotalBytes!,
                      ),
                    ),
                  ),
                ),
              ),
              isScale || zoom == 1
                  ? Container()
                  : Align(
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
              isScale || zoom == 1
                  ? Container()
                  : Positioned(
                      top: 15.0,
                      left: 15.0,
                      right: 15.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
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
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.greyColor.withOpacity(0.8),
                            ),
                            child: PopupMenuButton(
                              color: AppColors.whiteColor,
                              iconColor: Colors.white,
                              iconSize: 24,
                              itemBuilder: (BuildContext buildContext) {
                                return [
                                  const PopupMenuItem(
                                    value: "/save",
                                    child: Text(
                                      "Simpan Foto",
                                      style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ];
                              },
                              onSelected: (route) async {
                                if (route == "/save") {
                                  if (st.detailForum?.forumMedia != null &&
                                      indexImage <
                                          st.detailForum!.forumMedia!.length) {
                                    String imageUrl = st.detailForum!
                                            .forumMedia![indexImage].link ??
                                        "";

                                    if (imageUrl.isNotEmpty) {
                                      await DownloadHelper.downloadDoc(
                                          context: context, url: imageUrl);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Gagal mengunduh: URL tidak valid")),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Gagal mengunduh: Data media tidak ditemukan")),
                                    );
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      )),
            ],
          ),
        )),
      );
    });
  }
}
