import 'package:flutter/material.dart';
import '../../../misc/theme.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

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
        NewsDetailRoute(
          newsId: news.id ?? 0,
        ).push(context);
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: double.infinity,
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.whiteColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageCard(
                imageError: imageDefault,
                image: news.linkImage,
                radius: 15,
                height: 110,
                width: 170,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.title,
                        maxLines: 2,
                        style: AppTextStyles.textDialog.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
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
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}
