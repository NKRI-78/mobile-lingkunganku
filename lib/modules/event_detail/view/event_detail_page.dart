import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../widgets/photo_view/custom_fullscreen_preview.dart';
import '../cubit/event_detail_cubit.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({super.key, required this.idEvent});

  final int idEvent;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventDetailCubit()..fetchDetailEvent(idEvent),
      child: EventDetailView(
        idEvent: idEvent,
      ),
    );
  }
}

class EventDetailView extends StatelessWidget {
  const EventDetailView({super.key, required this.idEvent});

  final int idEvent;
  void _deleteEvent(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            "Hapus Event",
            style: AppTextStyles.textDialog.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            "Apakah Anda yakin ingin\nmenghapus event ini?",
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: Text(
                      "Batal",
                      style: AppTextStyles.textProfileBold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      context.read<EventDetailCubit>().removeEvent(idEvent);
                      GoRouter.of(context).pop();
                    },
                    child: Text(
                      "Hapus",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.textProfileBold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailCubit, EventDetailState>(
      builder: (context, state) {
        final String role = state.profile?.roleApp?.toUpperCase() ?? 'MEMBER';
        final eventData = state.event?.data;
        final imageUrl = eventData?.imageUrl?.isNotEmpty == true
            ? eventData?.imageUrl
            : null;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Detail Event",
              style: AppTextStyles.textStyle1,
            ),
            centerTitle: true,
            toolbarHeight: 100,
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
              if (role != "MEMBER" && role != "SECRETARY")
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.redColor,
                    size: 26,
                  ),
                  onPressed: () {
                    _deleteEvent(context);
                  },
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageCard(context, imageUrl),
                const SizedBox(height: 20),
                state.loading
                    ? _buildLoadingContent()
                    : _buildContent(eventData),
              ],
            ),
          ),
        );
      },
    );
  }
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

Widget _buildContent(eventData) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        eventData?.title ?? "",
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
        _formatDateTime(eventData?.createdAt),
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      const SizedBox(height: 10),
      Text(
        eventData?.description ?? "",
        textAlign: TextAlign.justify,
        style: const TextStyle(fontSize: 16),
      ),
    ],
  );
}

Widget _buildImageCard(BuildContext context, String? imageUrl) {
  return Card(
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: imageUrl != null
          ? GestureDetector(
              onTap: () => _showFullImage(context, imageUrl),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildShimmerPlaceholder(),
                errorWidget: (context, url, error) => _buildErrorPlaceholder(),
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
