import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../router/builder.dart';
import '../../../misc/text_style.dart';
import '../../../misc/theme.dart';

class ListIuranInfoSection extends StatelessWidget {
  final String userId;
  final String name;
  final String? avatarUrl;

  const ListIuranInfoSection({
    super.key,
    required this.userId,
    required this.name,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          IuranInfoDetailRoute(userId: userId).go(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                    ? CachedNetworkImageProvider(avatarUrl!) as ImageProvider
                    : const AssetImage(avatarDefault),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  name,
                  style: AppTextStyles.textDialog,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
