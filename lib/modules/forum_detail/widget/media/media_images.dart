import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../repositories/forum_repository/models/forums_model.dart';
import '../../../../router/builder.dart';
import '../../../../widgets/image/image_card_forum.dart';

class MediaImages extends StatelessWidget {
  const MediaImages({super.key, this.medias = const [], required this.idForum});

  final List<Media> medias;
  final int idForum;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _contentRender(context),
    );
  }

  List<Widget> _contentRender(BuildContext context) {
    switch (medias.length) {
      case 1:
        return _singleImageView(context);
      case 2:
        return _twoImageView(context);
      case 3:
        return _threeImageView(context);
      case 4:
        return _foureImageView(context);
      case 5:
        return _fiveImageView(context);
      default:
        return _multipleImageView(context);
    }
  }

  List<Widget> _singleImageView(BuildContext context) {
    return [
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () =>
              ClippedPhotoRoute(idForum: idForum, indexPhoto: 0).push(context),
          child: ImageCardForum(
            image: medias.first.link,
            radius: 0,
            width: double.infinity,
          ),
        ),
      ),
    ];
  }

  List<Widget> _twoImageView(BuildContext context) {
    return [
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () =>
              ClippedPhotoRoute(idForum: idForum, indexPhoto: 0).push(context),
          child: ImageCardForum(
            image: medias.first.link,
            radius: 0,
            width: double.infinity,
            height: 300,
          ),
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () =>
              ClippedPhotoRoute(idForum: idForum, indexPhoto: 1).push(context),
          child: ImageCardForum(
            image: medias.last.link,
            radius: 0,
            width: double.infinity,
            height: 300,
          ),
        ),
      )
    ];
  }

  List<Widget> _threeImageView(BuildContext context) {
    return [
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () =>
              ClippedPhotoRoute(idForum: idForum, indexPhoto: 0).push(context),
          child: ImageCardForum(
            image: medias[0].link,
            radius: 0,
            width: double.infinity,
            height: 305,
          ),
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
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 1)
                  .push(context),
              child: ImageCardForum(
                image: medias[1].link,
                radius: 0,
                width: double.infinity,
                height: 150,
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 2)
                  .push(context),
              child: ImageCardForum(
                image: medias[2].link,
                radius: 0,
                width: double.infinity,
                height: 150,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _foureImageView(BuildContext context) {
    return [
      Expanded(
        flex: 2,
        child: InkWell(
          onTap: () =>
              ClippedPhotoRoute(idForum: idForum, indexPhoto: 0).push(context),
          child: ImageCardForum(
            image: medias[0].link,
            radius: 0,
            width: double.infinity,
            height: 310,
          ),
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
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 1)
                  .push(context),
              child: ImageCardForum(
                image: medias[1].link,
                radius: 0,
                width: double.infinity,
                height: 100,
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 2)
                  .push(context),
              child: ImageCardForum(
                image: medias[2].link,
                radius: 0,
                width: double.infinity,
                height: 100,
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 3)
                  .push(context),
              child: ImageCardForum(
                image: medias[3].link,
                radius: 100,
                width: double.infinity,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _fiveImageView(BuildContext context) {
    return [
      Expanded(
        flex: 2,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 0)
                  .push(context),
              child: ImageCardForum(
                image: medias[0].link,
                radius: 0,
                width: double.infinity,
                height: 153,
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 1)
                  .push(context),
              child: ImageCardForum(
                image: medias[1].link,
                radius: 0,
                width: double.infinity,
                height: 153,
              ),
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
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 2)
                  .push(context),
              child: ImageCardForum(
                image: medias[2].link,
                radius: 0,
                width: double.infinity,
                height: 100,
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 3)
                  .push(context),
              child: ImageCardForum(
                image: medias[3].link,
                radius: 0,
                width: double.infinity,
                height: 100,
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 4)
                  .push(context),
              child: ImageCardForum(
                image: medias[4].link,
                radius: 100,
                width: double.infinity,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _multipleImageView(BuildContext context) {
    return [
      Expanded(
        flex: 2,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 0)
                  .push(context),
              child: ImageCardForum(
                image: medias[0].link,
                radius: 0,
                width: double.infinity,
                height: 153,
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 1)
                  .push(context),
              child: ImageCardForum(
                image: medias[1].link,
                radius: 0,
                width: double.infinity,
                height: 153,
              ),
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
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 2)
                  .push(context),
              child: ImageCardForum(
                image: medias[2].link,
                radius: 0,
                width: double.infinity,
                height: 100,
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 3)
                  .push(context),
              child: ImageCardForum(
                image: medias[3].link,
                radius: 0,
                width: double.infinity,
                height: 100,
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () => ClippedPhotoRoute(idForum: idForum, indexPhoto: 4)
                  .push(context),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    ImageCardForum(
                      image: medias[4].link,
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
            ),
          ],
        ),
      ),
    ];
  }
}
