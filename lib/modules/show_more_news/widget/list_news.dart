import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';

import '../../../repositories/home_repository/models/news_model.dart';
import '../../../router/builder.dart';
import '../../../widgets/image/image_card.dart';

class ListNews extends StatelessWidget {
  const ListNews({super.key, required this.news});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DetailNewsRoute(
          newsId: news.id ?? 0,
        ).go(context);
      },
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.whiteColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    bottomLeft: Radius.circular(18)),
                child: ImageCard(
                  image: news.linkImage,
                  radius: 30,
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      news.title,
                      maxLines: 2,
                      style: AppTextStyles.textDialog,
                      overflow: TextOverflow.visible,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      news.content.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ""),
                      maxLines: 2,
                      style: AppTextStyles.textWelcome,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
