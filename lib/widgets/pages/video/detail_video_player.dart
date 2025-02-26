import 'package:flutter/cupertino.dart';
import 'package:pod_player/pod_player.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../misc/colors.dart';

class DetailVideoPlayer extends StatefulWidget {
  const DetailVideoPlayer({super.key, required this.urlVideo});

  final String urlVideo;

  @override
  State<DetailVideoPlayer> createState() => _DetailVideoPlayerState();
}

class _DetailVideoPlayerState extends State<DetailVideoPlayer> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(widget.urlVideo,
            videoPlayerOptions:
                VideoPlayerOptions(allowBackgroundPlayback: true)),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: true,
          isLooping: true,
        ))
      ..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: VisibilityDetector(
        key: ObjectKey(controller),
        onVisibilityChanged: (VisibilityInfo info) {
          var visiblePercentage = info.visibleFraction * 100;
          debugPrint('Widget ${info.key} is $visiblePercentage% visible');
          if (info.visibleFraction == 0 && mounted) {
            controller.pause(); //pausing  functionality
          }
        },
        child: Stack(
          fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            PodVideoPlayer(
                podPlayerLabels: const PodPlayerLabels(
                  error: "Gagal memuat video",
                ),
                matchFrameAspectRatioToVideo: true,
                matchVideoAspectRatioToFrame: true,
                alwaysShowProgressBar: false,
                backgroundColor: Colors.black,
                controller: controller),
            Positioned(
                top: 50.0,
                left: 30.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoNavigationBarBackButton(
                      color: AppColors.whiteColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
