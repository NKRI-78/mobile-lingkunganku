import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../widgets/photo_view/custom_fullscreen_preview.dart';
import '../../../router/builder.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../cubit/news_detail_cubit.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({
    super.key,
    required this.newsId,
  });

  final int newsId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsDetailCubit()..fetchDetailNews(newsId),
      child: DetailNewsView(newsId: newsId),
    );
  }
}

class DetailNewsView extends StatelessWidget {
  const DetailNewsView({super.key, required this.newsId});

  final int newsId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsDetailCubit, NewsDetailState>(
      builder: (context, state) {
        final String role = state.profile?.roleApp?.toUpperCase() ?? 'MEMBER';
        final newsData = state.news?.data;
        final imageUrl = newsData?.linkImage?.isNotEmpty == true
            ? newsData?.linkImage
            : null;

        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Detail News",
              style: AppTextStyles.textStyle1,
            ),
            centerTitle: true,
            toolbarHeight: 80,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.buttonColor2,
                size: 24,
              ),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
            actions: [
              if (role != "MEMBER" &&
                  role != "TREASURER" &&
                  state.news?.data?.neighborhoodId != null)
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.buttonColor2,
                    size: 26,
                  ),
                  onPressed: () {
                    NewsUpdateRoute(newsId: newsId).push(context);
                  },
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageCard(context, imageUrl),
                const SizedBox(height: 10),
                state.loading
                    ? _buildLoadingContent()
                    : _buildContent(context, newsData),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShimmerPlaceholder(),
        const SizedBox(height: 8),
        _buildShimmerPlaceholder(),
        const SizedBox(height: 8),
        _buildShimmerPlaceholder(),
      ],
    );
  }

  Widget _buildContent(BuildContext context, newsData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          newsData?.title ?? "",
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          _formatDateTime(newsData?.createdAt),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Html(
          data: newsData?.content ?? "-",
          style: {
            "a": Style(
              color: Colors.blue,
            ),
          },
          onLinkTap:
              (String? url, Map<String, String> attributes, element) async {
            WebViewRoute(url: url!, title: "LINGKUNGANKU-MOBILE").push(context);
          },
        )
      ],
    );
  }

  Widget _buildImageCard(BuildContext context, String? imageUrl) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: imageUrl != null
            ? GestureDetector(
                onTap: () => _showFullImage(context, imageUrl),
                child: Hero(
                  tag: imageUrl,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => _buildShimmerPlaceholder(),
                    errorWidget: (context, url, error) =>
                        _buildErrorPlaceholder(),
                  ),
                ),
              )
            : _buildErrorPlaceholder(),
      ),
    );
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomFullscreenPreview(imageUrl: imageUrl),
      ),
    );
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        width: double.infinity,
        height: 20,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 10),
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
      final DateTime date = DateTime.parse(dateString).toLocal();
      return DateFormat("dd MMMM yyyy | HH.mm 'WIB'", "id").format(date);
    } catch (e) {
      return "-";
    }
  }
}
