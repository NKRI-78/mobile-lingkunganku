import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/transfer_management_cubit.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

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
                          color: AppColors.secondaryColor,
                        ),
                    errorWidget: (context, url, error) => Icon(
                          Icons.person,
                          color: Colors.white,
                        ))
                : Icon(
                    Icons.person,
                    color: Colors.white,
                  )),
      ),
      title: Text(name, style: AppTextStyles.textDialog),
      subtitle: Text(role, style: TextStyle(color: Colors.grey.shade600)),
      onTap: () {
        if (role.toLowerCase() == "ketua") {
          return _showPeringatanDialog(context);
        }
        debugPrint("ROLE DIPILIH : $role");
        _showTransferDialog(context, userId, name);
      },
    );
  }
}
