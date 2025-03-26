import 'package:flutter/material.dart';

import '../../../misc/colors.dart';
import '../../../misc/download_manager.dart';
import '../../../repositories/forum_repository/models/forums_model.dart';

class FilePage extends StatelessWidget {
  const FilePage({super.key, required this.forumMedia});

  final List<ForumMedia> forumMedia;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration:
          BoxDecoration(color: AppColors.greyColor.withValues(alpha: 0.8)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(forumMedia[0].link!.split('/').last,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 12,
                    )),
              ),
              const SizedBox(height: 6.0),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              await DownloadHelper.downloadDoc(
                  context: context, url: forumMedia.first.link ?? '');
            },
            color: AppColors.whiteColor,
          )
        ],
      ),
    );
  }
}
