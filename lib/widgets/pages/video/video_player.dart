import 'package:mobile_lingkunganku/router/builder.dart';
import 'package:pod_player/pod_player.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key, required this.urlVideo});

  final String urlVideo;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(
          widget.urlVideo,
          videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: true,
          ),
        ),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: false,
          isLooping: false,
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
    return InkWell(
      onTap: () {
        DetailVideoPlayerRoute(urlVideo: widget.urlVideo).push(context);
      },
      child: AbsorbPointer(
        absorbing: true,
        child: VisibilityDetector(
          key: ObjectKey(controller),
          onVisibilityChanged: (VisibilityInfo info) {
            var visiblePercentage = info.visibleFraction * 100;
            debugPrint('Widget ${info.key} is $visiblePercentage% visible');
            if (info.visibleFraction == 0 && mounted) {
              controller.pause(); //pausing  functionality
            }
          },
          child: PodVideoPlayer(
            podPlayerLabels: const PodPlayerLabels(
              error: "Gagal memuat video",
            ),
            matchFrameAspectRatioToVideo: true,
            matchVideoAspectRatioToFrame: true,
            alwaysShowProgressBar: true,
            controller: controller,
          ),
        ),
      ),
    );
  }
}
