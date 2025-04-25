import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../misc/colors.dart';
import '../../../router/builder.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key, required this.urlVideo});

  final String urlVideo;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.urlVideo))
          ..setLooping(false);
    await _videoController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      aspectRatio: _videoController.value.aspectRatio,
      autoPlay: false,
      looping: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Gagal memuat video: $errorMessage",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
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
          key: ObjectKey(_videoController),
          onVisibilityChanged: (VisibilityInfo info) {
            var visiblePercentage = info.visibleFraction * 100;
            debugPrint('Widget ${info.key} is $visiblePercentage% visible');
            if (info.visibleFraction == 0 && mounted) {
              _videoController.pause();
            }
          },
          child: _chewieController != null &&
                  _chewieController!.videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: Chewie(controller: _chewieController!),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondaryColor,
                  ),
                ),
        ),
      ),
    );
  }
}
