import 'package:flutter/material.dart';

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
        elevation: 2,
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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(18),
        bottomLeft: Radius.circular(18),
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: 170,
        height: 170,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/no_image.png',
          fit: BoxFit.cover,
          width: 170,
          height: 170,
        ),
      ),
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(
              content.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ""),
              maxLines: 2,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
