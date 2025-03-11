import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/transfer_management_cubit.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../misc/theme.dart';

part '_show_transfer_dialog.dart';
part '_show_peringatan_dialog.dart';

class MemberListSection extends StatelessWidget {
  final String userId;
  final String name;
  final String role;
  final String? avatarUrl;

  const MemberListSection({
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
      onTap: () {
        if (role.toLowerCase() == "ketua") {
          return _showPeringatanDialog(context);
        }
        print("ROLE DIPILIH : $role");
        _showTransferDialog(context, userId, name);
      },
    );
  }
}
