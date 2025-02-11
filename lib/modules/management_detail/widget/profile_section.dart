import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';
import 'package:mobile_lingkunganku/misc/theme.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/models/management_member_model.dart';

class ProfileSection extends StatelessWidget {
  final Members? member;

  const ProfileSection({super.key, this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: member?.profile?.avatarLink != null &&
                    member!.profile!.avatarLink.isNotEmpty
                ? NetworkImage(member!.profile!.avatarLink)
                : AssetImage(avatarDefault) as ImageProvider,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Text(
              member?.profile?.fullname ?? "Nama tidak tersedia",
              style: AppTextStyles.textDialog.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            member?.roleApp ?? 'Role tidak tersedia',
            style: AppTextStyles.textWelcome,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
