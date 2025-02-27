import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/repositories/forum_repository/models/forum_detail_model.dart';

import '../../../../widgets/image/image_card_forum.dart';

class MediaImages extends StatelessWidget {
  const MediaImages({super.key, this.medias = const []});

  final List<ForumMedia> medias;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _contentRender(),
    );
  }

  List<Widget> _contentRender() {
    switch (medias.length) {
      case 1:
        return _singleImageView();
      case 2:
        return _twoImageView();
      case 3:
        return _threeImageView();
      case 4:
        return _foureImageView();
      case 5:
        return _fiveImageView();
      default:
        return _multipleImageView();
    }
  }

  List<Widget> _singleImageView() {
    return [
      Expanded(
        flex: 1,
        child: ImageCardForum(
          image: medias.first.link ?? "",
          radius: 0,
          width: double.infinity,
        ),
      ),
    ];
  }

  List<Widget> _twoImageView() {
    return [
      Expanded(
        flex: 1,
        child: ImageCardForum(
          image: medias.first.link ?? "",
          radius: 0,
          width: double.infinity,
          height: 300,
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: ImageCardForum(
          image: medias.last.link ?? "",
          radius: 0,
          width: double.infinity,
          height: 300,
        ),
      )
    ];
  }

  List<Widget> _threeImageView() {
    return [
      Expanded(
        flex: 1,
        child: ImageCardForum(
          image: medias[0].link ?? "",
          radius: 0,
          width: double.infinity,
          height: 305,
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageCardForum(
              image: medias[1].link ?? "",
              radius: 0,
              width: double.infinity,
              height: 150,
            ),
            const SizedBox(height: 5),
            ImageCardForum(
              image: medias[2].link ?? "",
              radius: 0,
              width: double.infinity,
              height: 150,
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _foureImageView() {
    return [
      Expanded(
        flex: 2,
        child: ImageCardForum(
          image: medias[0].link ?? "",
          radius: 0,
          width: double.infinity,
          height: 310,
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCardForum(
              image: medias[1].link ?? "",
              radius: 0,
              width: double.infinity,
              height: 100,
            ),
            const SizedBox(height: 5),
            ImageCardForum(
              image: medias[2].link ?? "",
              radius: 0,
              width: double.infinity,
              height: 100,
            ),
            const SizedBox(height: 5),
            ImageCardForum(
              image: medias[3].link ?? "",
              radius: 100,
              width: double.infinity,
              height: 100,
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _fiveImageView() {
    return [
      Expanded(
        flex: 2,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageCardForum(
              image: medias[0].link ?? "",
              radius: 0,
              width: double.infinity,
              height: 153,
            ),
            const SizedBox(height: 5),
            ImageCardForum(
              image: medias[1].link ?? "",
              radius: 0,
              width: double.infinity,
              height: 153,
            ),
          ],
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCardForum(
              image: medias[2].link ?? "",
              radius: 0,
              width: double.infinity,
              height: 100,
            ),
            const SizedBox(height: 5),
            ImageCardForum(
              image: medias[3].link ?? "",
              radius: 0,
              width: double.infinity,
              height: 100,
            ),
            const SizedBox(height: 5),
            ImageCardForum(
              image: medias[4].link ?? "",
              radius: 100,
              width: double.infinity,
              height: 100,
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _multipleImageView() {
    return [
      Expanded(
        flex: 2,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageCardForum(
              image: medias[0].link ?? "",
              radius: 0,
              width: double.infinity,
              height: 153,
            ),
            const SizedBox(height: 5),
            ImageCardForum(
              image: medias[1].link ?? "",
              radius: 0,
              width: double.infinity,
              height: 153,
            ),
          ],
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCardForum(
              image: medias[2].link ?? "",
              radius: 0,
              width: double.infinity,
              height: 100,
            ),
            const SizedBox(height: 5),
            ImageCardForum(
              image: medias[3].link ?? "",
              radius: 0,
              width: double.infinity,
              height: 100,
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  ImageCardForum(
                    image: medias[4].link ?? "",
                    radius: 0,
                    width: double.infinity,
                  ),
                  Positioned.fill(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                          ),
                          child: Text(
                            '+${medias.length - 5}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: "Nulito",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
