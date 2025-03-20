import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../misc/text_style.dart';
import '../../../misc/theme.dart';
import '../../../router/builder.dart';

class MemberTile extends StatelessWidget {
  final String userId;
  final String name;
  final String role;
  final String? avatarUrl;

  const MemberTile({
    super.key,
    required this.userId,
    required this.name,
    required this.role,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey.shade300,
        backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
            ? CachedNetworkImageProvider(avatarUrl!) as ImageProvider
            : const AssetImage(avatarDefault),
      ),
      title: Text(name, style: AppTextStyles.textDialog),
      subtitle: Text(role, style: TextStyle(color: Colors.grey.shade600)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Kirim userId ke halaman detail
        ManagementDetailRoute(userId: userId).go(context);
      },
    );
  }
}
