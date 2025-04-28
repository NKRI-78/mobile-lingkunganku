import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../misc/colors.dart';
import '../../../repositories/forum_repository/models/forums_model.dart';
import '../../../widgets/detect_text/detect_text.dart';
import '../../../widgets/image/image_avatar.dart';

class CommentForum extends StatelessWidget {
  const CommentForum({
    super.key,
    required this.comment,
  });

  final ForumComment comment;

  @override
  Widget build(BuildContext context) {
    final user = comment.user;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 0,
                child: InkWell(
                    onTap: () {},
                    child: ImageAvatar(
                      image: user?.profile.avatarLink == null
                          ? user?.profile.avatarLink ?? ""
                          : user?.profile.avatarLink ?? "",
                      radius: 25,
                    )),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: AppColors.greyColor.withValues(alpha: 0.3)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text(
                                  user?.profile == null
                                      ? user?.profile.fullname ?? ""
                                      : user?.profile.fullname ?? "",
                                  style: const TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          DetectText(
                            text: comment.comment ?? "",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          timeago.format(
                            comment.createdAt != null
                                ? DateTime.parse(comment.createdAt!)
                                : DateTime.now(),
                            locale: 'id',
                          ),
                          style: const TextStyle(
                              color: AppColors.greyColor, fontSize: 12),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Balas",
                          style: TextStyle(
                              color: AppColors.greyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
