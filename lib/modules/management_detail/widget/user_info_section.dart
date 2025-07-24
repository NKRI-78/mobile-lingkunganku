import 'package:flutter/material.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../repositories/management_repository/models/management_detail_member_model.dart';

class UserInfoSection extends StatelessWidget {
  final MemberData? member;
  const UserInfoSection({super.key, this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nama",
            style: AppTextStyles.textWelcome.copyWith(fontSize: 14),
          ),
          Text(
            member?.profile?.fullname ?? "Nama tidak tersedia",
            style: AppTextStyles.textStyle2
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Alamat",
            style: AppTextStyles.textWelcome.copyWith(fontSize: 14),
          ),
          Text(
            member?.profile?.detailAddress ?? "Alamat tidak tersedia",
            style: AppTextStyles.textStyle2
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Email",
            style: AppTextStyles.textWelcome.copyWith(fontSize: 14),
          ),
          Text(
            member?.email ?? "Email tidak tersedia",
            style: AppTextStyles.textStyle2
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
