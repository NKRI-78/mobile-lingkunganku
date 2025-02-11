import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';

import '../../../misc/text_style.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

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
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nama",
            style: AppTextStyles.textWelcome.copyWith(fontSize: 14),
          ),
          Text(
            "Hernan Febri Rahmatullah",
            style: AppTextStyles.textStyle2.copyWith(fontSize: 18),
          ),
          Text(
            "Alamat",
            style: AppTextStyles.textWelcome.copyWith(fontSize: 14),
          ),
          Text(
            "Jl. Bambu Kuning no. 53",
            style: AppTextStyles.textStyle2.copyWith(fontSize: 18),
          ),
          Text(
            "Email",
            style: AppTextStyles.textWelcome.copyWith(fontSize: 14),
          ),
          Text(
            "hernanfebri@gmail.com",
            style: AppTextStyles.textStyle2.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
