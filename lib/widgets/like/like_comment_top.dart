import 'package:flutter/material.dart';

import '../../misc/asset_source.dart';
import '../../misc/colors.dart';

class LikeCommentTop extends StatelessWidget {
  const LikeCommentTop({
    super.key,
    required this.onPressedLike,
    required this.onPressedComment,
    required this.isLike,
    required this.countLike,
    required this.countComment,
  });

  final int isLike;
  final int countLike;
  final int countComment;
  final Function() onPressedLike;
  final Function() onPressedComment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
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
                      // GeneralModal.showModalUserLike(context, forumsModel);
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
          ),
        ),
        const Divider(
          thickness: .3,
          color: AppColors.blackColor,
        ),
      ],
    );
  }
}
