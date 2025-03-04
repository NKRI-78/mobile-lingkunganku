import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/widgets/pages/file/file_page.dart';
import '../cubit/forum_cubit.dart';
import 'comment_forum.dart';
import 'media/media_images.dart';
import '../../../repositories/forum_repository/models/forums_model.dart';
import '../../../router/builder.dart';
import '../../../widgets/pages/video/video_player.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      color: AppColors.whiteColor,
      child: InkWell(
        onTap: () {
          ForumDetailRoute(idForum: forums.id.toString()).go(context);
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: DetectText(
                text: forums.description ?? '',
              ),
            ),
            Stack(
              fit: StackFit.loose,
              alignment: Alignment.bottomRight,
              children: [
                // Menampilkan gambar
                if ((forums.forumMedia?.isNotEmpty ?? false) &&
                    forums.forumMedia?.first.type == "image")
                  InkWell(
                    onTap: () {
                      ClippedPhotoRoute(idForum: forums.id ?? 0, indexPhoto: 0)
                          .push(context);
                    },
                    child: MediaImages(
                      medias: forums.forumMedia ?? [],
                    ),
                  ),

                // Menampilkan video
                if ((forums.forumMedia?.isNotEmpty ?? false) &&
                    forums.forumMedia?.first.type == "video")
                  VideoPlayer(urlVideo: forums.forumMedia?.first.link ?? ""),

                // Menampilkan file dokumen
                if ((forums.forumMedia?.isNotEmpty ?? false) &&
                    forums.forumMedia?.first.type == "file")
                  FilePage(forums: forums)
              ],
            ),

            // Like & Comment Top (Total)
            LikeCommentTop(
              countLike: forums.likeCount ?? 0,
              countComment: forums.commentCount ?? 0,
              isLike: forums.isLike ?? false,
              onPressedLike: () async {},
              onPressedComment: () {},
            ),

            // Like & Comment Bottom (Detail)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LikeComment(
                countLike: forums.likeCount ?? 0,
                isLike: forums.isLike ?? false,
                onPressedLike: () async {
                  await context
                      .read<ForumCubit>()
                      .setLikeUnlikeForum(idForum: forums.id.toString());
                },
                onPressedComment: () {},
              ),
            ),

            // Komentar Forum
            forums.forumComment!.isEmpty
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: forums.forumComment!
                        .map(
                          (e) => InkWell(
                              onTap: () {},
                              child: CommentForum(
                                comment: e,
                              )),
                        )
                        .toList(),
                  ),

            // Divider
            Divider(
              color: AppColors.greyColor.withValues(alpha: 0.1),
              thickness: 10,
            ),
          ],
        ),
      ),
    );
  }
}
