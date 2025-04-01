import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';

import '../../../misc/text_style.dart';
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
        radius: 25,
        backgroundColor: AppColors.secondaryColor,
        child: ClipOval(
            child: avatarUrl != null && avatarUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: avatarUrl!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(
                        color: AppColors.secondaryColor),
                    errorWidget: (context, url, error) => Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  )
                : Icon(
                    Icons.person,
                    color: Colors.white,
                  )),
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
