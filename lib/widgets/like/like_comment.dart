import 'package:flutter/material.dart';

import '../../misc/asset_source.dart';
import '../../misc/colors.dart';

class LikeComment extends StatelessWidget {
  const LikeComment(
      {super.key,
      required this.onPressedLike,
      required this.onPressedComment,
      required this.isLike,
      required this.countLike});

  final int isLike;
  final int countLike;
  final Function() onPressedLike;
  final Function() onPressedComment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLike == 1
                    ? Image.asset(AssetSource.likeFillIcon,
                        width: 25, height: 25, color: AppColors.greyColor)
                    : Image.asset(AssetSource.likeIcon,
                        width: 20, height: 20, color: AppColors.greyColor),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "Suka",
                  style: TextStyle(color: AppColors.greyColor, fontSize: 14),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AssetSource.commentIcon,
                  width: 25,
                  height: 25,
                  color: AppColors.greyColor,
                ),
                const Text(
                  "Komentar",
                  style: TextStyle(color: AppColors.greyColor, fontSize: 14),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
