import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../cubit/detail_news_cubit.dart';

class DetailNewsPage extends StatelessWidget {
  const DetailNewsPage({super.key, required this.newsId});

  final int newsId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailNewsCubit()..fetchDetailNews(newsId),
      child: DetailNewsView(newsId: newsId),
    );
  }
}

class DetailNewsView extends StatelessWidget {
  const DetailNewsView({super.key, required this.newsId});

  final int newsId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailNewsCubit, DetailNewsState>(
      buildWhen: (previous, current) => previous.news != current.news,
      builder: (context, state) {
        final newsData = state.news?.data;
        final imageUrl =
            (newsData?.linkImage ?? "").isNotEmpty ? newsData!.linkImage : null;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "News",
              style: AppTextStyles.textStyle1,
            ),
            centerTitle: true,
            toolbarHeight: 100,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.buttonColor2,
                size: 32,
              ),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageCard(imageUrl),
                const SizedBox(height: 16),
                Text(
                  newsData?.title ?? "-",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDateTime(newsData?.createdAt),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  newsData?.content ?? "-",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageCard(String? imageUrl) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: imageUrl != null
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildShimmerPlaceholder(),
                errorWidget: (context, url, error) => _buildErrorPlaceholder(),
              )
            : _buildErrorPlaceholder(),
      ),
    );
  }

  Widget _buildShimmerPlaceholder() {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[200]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.grey[300],
      child: Center(
        child: Image.asset(
          'assets/images/no_image.png',
          width: 100,
          height: 100,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  String _formatDateTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return "-";
    }

    try {
      final DateTime date = DateTime.parse(dateString);
      return DateFormat("dd MMMM yyyy | HH.mm 'WIB'").format(date);
    } catch (e) {
      return "-";
    }
  }
}
