import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CustomCardNewsSection extends StatelessWidget {
  final String linkImage;
  final String title;
  final String content;

  const CustomCardNewsSection({
    super.key,
    required this.linkImage,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            _CardImage(linkImage: linkImage),
            const SizedBox(width: 16),
            _CardContent(title: title, content: content),
          ],
        ),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  final String linkImage;

  const _CardImage({required this.linkImage});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(18),
        bottomLeft: Radius.circular(18),
      ),
      child: Image.asset(
        linkImage,
        fit: BoxFit.fill,
        width: 150,
        height: 150,
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final String title;
  final String content;

  const _CardContent({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Html(
            data: content,
            style: {
              "a": Style(
                color: Colors.blue,
              ),
            },
            onLinkTap:
                (String? url, Map<String, String> attributes, element) async {
              // WebViewRoute(url: url!, title: "MHS-MOBILE").go(context);
            },
          )
        ],
      ),
    );
  }
}
