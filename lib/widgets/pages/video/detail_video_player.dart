import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../misc/download_manager.dart';

class DetailVideoPlayer extends StatefulWidget {
  const DetailVideoPlayer({super.key, required this.urlVideo});

  final String urlVideo;

  @override
  State<DetailVideoPlayer> createState() => _DetailVideoPlayerState();
}

class _DetailVideoPlayerState extends State<DetailVideoPlayer> {
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
      autoPlay: true,
      looping: false,
      showControls: false,
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

  void _downloadVideo() {
    DownloadHelper.downloadDoc(context: context, url: widget.urlVideo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'download') {
                _downloadVideo();
              }
            },
            color: Colors.white,
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'download',
                child: Row(
                  children: [
                    Icon(Icons.download, color: Colors.black),
                    SizedBox(width: 8),
                    Text("Download Video"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: VisibilityDetector(
        key: ObjectKey(_videoController),
        onVisibilityChanged: (VisibilityInfo info) {
          var visiblePercentage = info.visibleFraction * 100;
          debugPrint('Widget ${info.key} is $visiblePercentage% visible');
          if (info.visibleFraction == 0 && mounted) {
            _videoController.pause();
          }
        },
        child: Center(
          child: _chewieController != null &&
                  _chewieController!.videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: Chewie(controller: _chewieController!),
                )
              : const CircularProgressIndicator(
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
