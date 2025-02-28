import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../misc/colors.dart';
import '../cubit/forum_create_cubit.dart';

class ThumbnailMedia extends StatelessWidget {
  const ThumbnailMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForumCreateCubit, ForumCreateState>(
      builder: (context, st) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (st.pickedFile.isNotEmpty)
                st.loadingUpload
                    ? const CircularProgressIndicator.adaptive()
                    : GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: st.pickedFile.length,
                        itemBuilder: (context, index) {
                          bool isVideo =
                              st.pickedFile[index].path.endsWith(".mp4");

                          return Stack(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                margin: const EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: isVideo
                                        ? MemoryImage(st.videoFileThumbnail!)
                                        : FileImage(
                                                File(st.pickedFile[index].path))
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if (isVideo)
                                const Positioned(
                                  top: 30,
                                  left: 30,
                                  child: Icon(
                                    Icons.play_circle_fill,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<ForumCreateCubit>()
                                        .removeFileAt(index);
                                  },
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
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              if (st.pickedFile.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      const Text("Total File Size:",
                          style: TextStyle(
                            color: AppColors.blackColor,
                          )),
                      const SizedBox(width: 8.0),
                      Text(
                        "${st.fileSize} ",
                        style: const TextStyle(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
