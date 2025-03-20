import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../repositories/forum_repository/models/forums_model.dart';
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
        return _singleMediaView();
      case 2:
        return _twoMediaView();
      case 3:
        return _threeMediaView();
      case 4:
        return _fourMediaView();
      case 5:
        return _fiveMediaView();
      default:
        return _multipleMediaView();
    }
  }

  Widget _buildMedia(ForumMedia media, double height) {
    bool isVideo = media.type == 'video';
    return Stack(
      alignment: Alignment.center,
      children: [
        ImageCardForum(
          image: media.link ?? "",
          radius: 0,
          width: double.infinity,
          height: height,
        ),
        if (isVideo)
          const Icon(
            Icons.play_circle_fill,
            color: Colors.white,
            size: 40,
          ),
      ],
    );
  }

  List<Widget> _singleMediaView() {
    return [
      Expanded(
        flex: 1,
        child: _buildMedia(medias.first, 300),
      ),
    ];
  }

  List<Widget> _twoMediaView() {
    return [
      Expanded(
        flex: 1,
        child: _buildMedia(medias[0], 300),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: _buildMedia(medias[1], 300),
      ),
    ];
  }

  List<Widget> _threeMediaView() {
    return [
      Expanded(
        flex: 1,
        child: _buildMedia(medias[0], 305),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: Column(
          children: [
            _buildMedia(medias[1], 150),
            const SizedBox(height: 5),
            _buildMedia(medias[2], 150),
          ],
        ),
      ),
    ];
  }

  List<Widget> _fourMediaView() {
    return [
      Expanded(
        flex: 2,
        child: _buildMedia(medias[0], 310),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: Column(
          children: [
            _buildMedia(medias[1], 100),
            const SizedBox(height: 5),
            _buildMedia(medias[2], 100),
            const SizedBox(height: 5),
            _buildMedia(medias[3], 100),
          ],
        ),
      ),
    ];
  }

  List<Widget> _fiveMediaView() {
    return [
      Expanded(
        flex: 2,
        child: Column(
          children: [
            _buildMedia(medias[0], 153),
            const SizedBox(height: 5),
            _buildMedia(medias[1], 153),
          ],
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: Column(
          children: [
            _buildMedia(medias[2], 100),
            const SizedBox(height: 5),
            _buildMedia(medias[3], 100),
            const SizedBox(height: 5),
            _buildMedia(medias[4], 100),
          ],
        ),
      ),
    ];
  }

  List<Widget> _multipleMediaView() {
    return [
      Expanded(
        flex: 2,
        child: Column(
          children: [
            _buildMedia(medias[0], 153),
            const SizedBox(height: 5),
            _buildMedia(medias[1], 153),
          ],
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: Column(
          children: [
            _buildMedia(medias[2], 100),
            const SizedBox(height: 5),
            _buildMedia(medias[3], 100),
            const SizedBox(height: 5),
            Stack(
              alignment: Alignment.center,
              children: [
                _buildMedia(medias[4], 100),
                Positioned.fill(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.black.withOpacity(0.1),
                        child: Text(
                          '+${medias.length - 5}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }
}
