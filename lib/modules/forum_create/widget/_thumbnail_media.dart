import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../misc/colors.dart';
import '../../../widgets/pages/video/detail_video_player.dart';
import '../cubit/forum_create_cubit.dart';

class ThumbnailMedia extends StatelessWidget {
  const ThumbnailMedia({super.key});

  @override
  Widget build(BuildContext context) {
    const videoExtensions = [
      'mp4',
      'avi',
      'mkv',
      'mov',
      '3gp',
      'wmv',
      'flv',
      'mpeg',
      'mpg',
      'webm'
    ];

    return BlocBuilder<ForumCreateCubit, ForumCreateState>(
      builder: (context, st) {
        List<File> picked = st.pickedFile;
        final videoFiles = picked.where((f) {
          final ext = f.path.split('.').last.toLowerCase();
          return videoExtensions.contains(ext);
        }).toList();

        final imageOrDocFiles = picked.where((f) {
          final ext = f.path.split('.').last.toLowerCase();
          return !videoExtensions.contains(ext);
        }).toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (picked.isNotEmpty) ...[
                st.loadingUpload
                    ? const CircularProgressIndicator.adaptive()
                    : Column(
                        children: [
                          ...videoFiles.asMap().entries.map((entry) {
                            final file = entry.value;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              width: double.infinity,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: MemoryImage(st.videoFileThumbnail!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => DetailVideoPlayer(
                                            urlVideo: file.path,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Center(
                                      child: Icon(
                                        Icons.play_circle_fill,
                                        color: Colors.white,
                                        size: 80,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: GestureDetector(
                                      onTap: () => context
                                          .read<ForumCreateCubit>()
                                          .removeFileAt(picked.indexOf(file)),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList(),

                          // Tampilkan gambar & dokumen dalam grid
                          if (imageOrDocFiles.isNotEmpty)
                            GridView.builder(
                              itemCount: imageOrDocFiles.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              itemBuilder: (context, i) {
                                final item = imageOrDocFiles[i];
                                final isDoc = item.path.contains(RegExp(
                                    r'\.pdf$|\.doc$|\.txt$|\.zip$|\.rar$|\.xlsx$'));

                                return Stack(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: isDoc
                                              ? const AssetImage(
                                                  'assets/icons/document.png')
                                              : FileImage(item)
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      top: 5,
                                      child: GestureDetector(
                                        onTap: () => context
                                            .read<ForumCreateCubit>()
                                            .removeFileAt(picked.indexOf(item)),
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                        ],
                      ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("Total Ukuran File :",
                        style: TextStyle(color: AppColors.blackColor)),
                    const SizedBox(width: 8.0),
                    Text(
                      st.fileSize.contains("MB")
                          ? st.fileSize
                          : "${st.fileSize} MB",
                      style: const TextStyle(color: AppColors.blackColor),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
