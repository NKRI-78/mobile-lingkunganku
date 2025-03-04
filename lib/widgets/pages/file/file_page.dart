import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../misc/colors.dart';
import '../../../repositories/forum_repository/models/forums_model.dart';

class FilePage extends StatelessWidget {
  final ForumsModel forums;

  const FilePage({super.key, required this.forums});

  @override
  Widget build(BuildContext context) {
    // Pastikan ada file untuk ditampilkan
    if (forums.forumMedia == null || forums.forumMedia!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: forums.forumMedia!.map((media) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.greyColor.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Nama file
              Expanded(
                child: Text(media.link!.split('/').last,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.textProfileNormal),
              ),
              const SizedBox(width: 10),

              // Ikon download
              InkWell(
                onTap: () async {
                  final url = media.link ?? "";
                  if (await canLaunchUrl(Uri.parse(url))) {
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
