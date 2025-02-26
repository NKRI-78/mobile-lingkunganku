import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/modules/forum/cubit/forum_cubit.dart';
import 'package:mobile_lingkunganku/modules/forum/widget/comment_forum.dart';
import 'package:mobile_lingkunganku/modules/forum/widget/media/media_images.dart';
import 'package:mobile_lingkunganku/repositories/forum_repository/models/forums_model.dart';
import 'package:mobile_lingkunganku/widgets/pages/video/video_player.dart';

import '../../../misc/colors.dart';
import '../../../misc/modal.dart';
import '../../../widgets/card_header/card_header_forum.dart';
import '../../../widgets/detect_text/detect_text.dart';
import '../../../widgets/like/like_comment.dart';
import '../../../widgets/like/like_comment_top.dart';

class ForumListSection extends StatelessWidget {
  const ForumListSection({super.key, required this.forums});

  final ForumsModel forums;

  @override
  Widget build(BuildContext context) {
    debugPrint("Media data: ${forums.forumMedia}");

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      color: AppColors.whiteColor,
      child: InkWell(
        onTap: () {
          // Navigasi ke detail forum (jika ada fitur ini)
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Forum
            CardHeaderForum(
              forums: forums,
              onSelected: (value) {
                debugPrint("Value is : $value");
                if (value == "/delete") {
                  GeneralModal.showConfirmModal(
                    msg: "Anda yakin ingin menghapusnya?",
                    context: context,
                    onPressed: () async {
                      context
                          .read<ForumCubit>()
                          .deleteForum(idForum: forums.id.toString());
                      Navigator.pop(context);
                    },
                    locationImage: 'assets/icons/delete-icon.png',
                  );
                } else {
                  GeneralModal.showConfirmModal(
                    msg: "Anda yakin ingin melaporkannya?",
                    context: context,
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    locationImage: 'assets/icons/delete-icon.png',
                  );
                }
              },
            ),

            // Deskripsi Forum
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: DetectText(
                text: forums.description ?? '',
              ),
            ),

            Stack(
              fit: StackFit.loose,
              alignment: Alignment.bottomRight,
              children: [
                if ((forums.forumMedia?.isNotEmpty ?? false) &&
                    forums.forumMedia?.first.type == "image")
                  InkWell(
                    onTap: () {
                      //
                    },
                    child: MediaImages(
                      medias: forums.forumMedia ?? [],
                    ),
                  ),
                if ((forums.forumMedia?.isNotEmpty ?? false) &&
                    forums.forumMedia?.first.type == "video")
                  VideoPlayer(urlVideo: forums.forumMedia?.first.link ?? "")
              ],
            ),

            // Like & Comment Top (Total)
            LikeCommentTop(
              countLike: 0,
              countComment: 0,
              isLike: 0,
              onPressedLike: () {},
              onPressedComment: () {},
            ),

// Like & Comment Bottom (Detail)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LikeComment(
                countLike: 0,
                isLike: 0,
                onPressedLike: () {},
                onPressedComment: () {},
              ),
            ),

            // Komentar Forum
            if (forums.forumComment != null && forums.forumComment!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: forums.forumComment!
                    .map(
                      (e) => InkWell(
                        onTap: () {},
                        child: CommentForum(comment: e),
                      ),
                    )
                    .toList(),
              ),

            // Divider
            Divider(
              color: AppColors.greyColor.withOpacity(0.1),
              thickness: 10,
            ),
          ],
        ),
      ),
    );
  }
}
