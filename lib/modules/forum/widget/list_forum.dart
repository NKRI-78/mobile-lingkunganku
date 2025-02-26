import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/modules/forum/cubit/forum_cubit.dart';
import 'package:mobile_lingkunganku/modules/forum/widget/comment_forum.dart';
import 'package:mobile_lingkunganku/modules/forum/widget/media/media_images.dart';
import 'package:mobile_lingkunganku/repositories/forum_repository/models/forums_model.dart';

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
    debugPrint("Media data: ${forums.media}");

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      color: AppColors.whiteColor,
      child: InkWell(
        onTap: () {
          // DetailPreLovedRoute(idPreloved: preLove.id.toString()).go(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardHeaderForum(
              forums: forums,
              onSelected: (value) {
                debugPrint("Value is : $value");
                if (value == "/delete") {
                  GeneralModal.showConfirmModal(
                      msg: "Anda yakin ingin menghapusnya ?",
                      context: context,
                      onPressed: () async {
                        context
                            .read<ForumCubit>()
                            .deleteForum(idForum: forums.id.toString());
                        Navigator.pop(context);
                      },
                      locationImage: 'assets/icons/delete-icon.png');
                } else {
                  GeneralModal.showConfirmModal(
                      msg: "Anda yakin ingin melaporkanya ?",
                      context: context,
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      locationImage: 'assets/icons/delete-icon.png');
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: DetectText(
                text: forums.description,
              ),
            ),
            if (forums.media.isNotEmpty)
              MediaImages(
                medias: forums.media,
              ),
            LikeCommentTop(
              countLike: 0,
              countComment: 0,
              isLike: 0,
              onPressedLike: () async {},
              onPressedComment: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LikeComment(
                countLike: 0,
                isLike: 0,
                onPressedLike: () async {},
                onPressedComment: () {},
              ),
            ),
            forums.comment.isEmpty
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: forums.comment
                        .map(
                          (e) => InkWell(
                              onTap: () {},
                              child: CommentForum(
                                comment: e,
                              )),
                        )
                        .toList()),
            Divider(
              color: AppColors.greyColor.withOpacity(0.1),
              thickness: 12,
            ),
          ],
        ),
      ),
    );
  }
}
