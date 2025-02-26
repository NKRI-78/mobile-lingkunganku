import 'package:flutter/material.dart';

import '../../misc/asset_source.dart';
import '../../misc/colors.dart';
import '../../repositories/forum_repository/models/forums_model.dart';

class LikeTopComment extends StatelessWidget {
  const LikeTopComment({
    super.key,
    required this.onPressedLike,
    required this.onPressedComment,
    required this.isLike,
    required this.countLike,
    required this.countComment,
    required this.commentData,
  });

  final int isLike;
  final int countLike;
  final int countComment;
  final Function() onPressedLike;
  final Function() onPressedComment;
  final Comment commentData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLike == 1
                ? Image.asset(
                    AssetSource.likeFillIcon,
                    width: 25,
                    height: 25,
                  )
                : Image.asset(
                    AssetSource.likeIcon,
                    width: 20,
                    height: 20,
                  ),
            InkWell(
              onTap: () {
                // GeneralModal.showModalUserLikeComment(context, commentData);
              },
              child: Text(
                "$countLike Suka",
                style: const TextStyle(color: AppColors.greyColor),
              ),
            )
          ],
        ),
        Text(
          "$countComment Jawaban",
          style: const TextStyle(color: AppColors.greyColor),
        )
        // IconButton(
        //   onPressed: onPressedComment,
        //   icon: Image.asset(commentIcon)
        // ),
      ],
    );
  }
}
