import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';
import '../../../misc/theme.dart';
import '../../../widgets/image/image_card.dart';

class CustomNewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String content;
  final VoidCallback onTap;

  const CustomNewsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(right: 18, left: 18, bottom: 10, top: 10),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 110,
          child: Row(
            children: [
              _NewsImage(imageUrl: imageUrl),
              const SizedBox(width: 5),
              _NewsContent(title: title, content: content),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsImage extends StatelessWidget {
  final String imageUrl;

  const _NewsImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ImageCard(
      image: imageUrl,
      fit: BoxFit.cover,
      width: 170,
      height: 110,
      imageError: imageDefault,
      radius: 15,
    );
  }
}

class _NewsContent extends StatelessWidget {
  final String title;
  final String content;

  const _NewsContent({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              title,
              style: AppTextStyles.textDialog.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 3),
            Text(
              content.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ""),
              maxLines: 2,
              style: AppTextStyles.textWelcome,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
