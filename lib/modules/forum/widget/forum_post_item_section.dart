import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';
import 'package:mobile_lingkunganku/misc/theme.dart';
import '../../../misc/colors.dart';

class ForumPostItem extends StatelessWidget {
  final String? avatarUrl;
  final String? username;
  final String? timeAgo;
  final String? content;
  final List<String>? images;
  final int likes;
  final int answers;

  const ForumPostItem({
    super.key,
    this.avatarUrl,
    this.username,
    this.timeAgo,
    this.content,
    this.images,
    this.likes = 0,
    this.answers = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                  ? CachedNetworkImageProvider(avatarUrl!)
                  : const AssetImage(avatarDefault) as ImageProvider,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username ?? "Tidak Tersedia",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    timeAgo ?? "Just now",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (content != null && content!.isNotEmpty) ...[
          Text(
            content!,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 10),
        ],
        if (images != null && images!.isNotEmpty) _buildImageGallery(images!),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.thumb_up_alt_outlined,
                  color: AppColors.likeColor,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Text("$likes Likes"),
              ],
            ),
            Text("$answers Answers"),
          ],
        ),
        const SizedBox(height: 10),
        Divider(color: AppColors.greyColor.withOpacity(0.3)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.thumb_up_alt_outlined,
                color: AppColors.greyColor,
                size: 20,
              ),
              label: Text(
                "Like",
                style: AppTextStyles.textWelcome.copyWith(fontSize: 14),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.chat_bubble_outline_rounded,
                color: AppColors.greyColor,
                size: 20,
              ),
              label: Text(
                "Comment",
                style: AppTextStyles.textWelcome.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageGallery(List<String> imageUrls) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: imageUrls.length > 4 ? 4 : imageUrls.length,
        itemBuilder: (context, index) {
          if (index == 3 && imageUrls.length > 4) {
            return Stack(
              children: [
                _buildImage(imageUrls[index]),
                Container(
                  color: Colors.black54,
                  alignment: Alignment.center,
                  child: Text(
                    "+${imageUrls.length - 3}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          }
          return _buildImage(imageUrls[index]);
        },
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[300],
        ),
        errorWidget: (context, url, error) =>
            const Icon(Icons.broken_image, color: Colors.grey),
      ),
    );
  }
}
