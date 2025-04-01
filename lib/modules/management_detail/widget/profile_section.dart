import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../repositories/management_repository/models/management_detail_member_model.dart';

class ProfileSection extends StatelessWidget {
  final MemberData? member;

  const ProfileSection({super.key, this.member});

  @override
  Widget build(BuildContext context) {
    // print("🔍 Debugging Member: ${member?.profile?.fullname}");
    // print("🔍 Debugging Detail Address: ${member?.profile?.detailAddress}");

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
            backgroundColor: AppColors.secondaryColor,
            child: ClipOval(
              child: member?.profile?.avatarLink != null &&
                      member!.profile!.avatarLink!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: member!.profile!.avatarLink!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CircularProgressIndicator(
                        color: AppColors.secondaryColor,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.person, color: Colors.white),
                    )
                  : const Icon(Icons.person, color: Colors.white),
            ),
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
            member?.translateRoleApp ?? 'Role tidak tersedia',
            style: AppTextStyles.textWelcome,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
