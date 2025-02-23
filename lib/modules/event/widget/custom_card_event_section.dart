import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:shimmer/shimmer.dart';
import '../../../misc/text_style.dart';

class CustomCardEventSection extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback? onTap;

  const CustomCardEventSection({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.startDate,
    required this.endDate,
    this.onTap,
  });

  String formatDateRange(DateTime? startDate, DateTime? endDate) {
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm');

    if (startDate == null || endDate == null) {
      return "Tanggal tidak tersedia";
    }

    startDate = startDate.toLocal();
    endDate = endDate.toLocal();

    String getTimeZone(DateTime date) {
      int offset = date.timeZoneOffset.inHours;
      if (offset == 7) return "WIB";
      if (offset == 8) return "WITA";
      if (offset == 9) return "WIT";
      return "UTC";
    }

    return "${dateFormat.format(startDate)} ${getTimeZone(startDate)} - "
        "${dateFormat.format(endDate)} ${getTimeZone(endDate)}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 4,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          splashColor: Colors.grey.withOpacity(0.5),
          highlightColor: Colors.grey.withOpacity(0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageCard(imageUrl),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title.isNotEmpty ? title : "Judul Tidak Tersedia",
                            style: AppTextStyles.textDialog.copyWith(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            formatDateRange(startDate, endDate),
                            style: AppTextStyles.textWelcome,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColors.greyColor.withOpacity(0.3),
                      ),
                      child: IconButton(
                        onPressed: onTap,
                        icon: const Icon(Icons.arrow_forward_rounded),
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(String? imageUrl) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: imageUrl != null && imageUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
              placeholder: (context, url) => _buildShimmerPlaceholder(),
              errorWidget: (context, url, error) => _buildErrorPlaceholder(),
            )
          : _buildErrorPlaceholder(),
    );
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        width: double.infinity,
        height: 150,
        color: Colors.white,
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      width: double.infinity,
      height: 150,
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
}
