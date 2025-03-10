import 'package:flutter/material.dart';
import '../../../../misc/colors.dart';
import '../../../../misc/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../repositories/forum_repository/models/forum_detail_model.dart';

class MediaFile extends StatelessWidget {
  final ForumDetailModel forum;

  const MediaFile({super.key, required this.forum});

  @override
  Widget build(BuildContext context) {
    // Ambil hanya media dengan type "file"
    final fileMediaList =
        forum.forumMedia?.where((media) => media.type == "file").toList() ?? [];

    // Jika tidak ada file, jangan tampilkan apapun
    if (fileMediaList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: fileMediaList.map((media) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.greyColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Nama file
              Expanded(
                child: Text(
                  media.link?.split('/').last ?? "Unknown File",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.textProfileNormal,
                ),
              ),
              const SizedBox(width: 10),

              // Ikon download
              InkWell(
                onTap: () async {
                  final url = media.link ?? "";
                  if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  }
                },
                child: const Icon(Icons.download, color: Colors.white),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
