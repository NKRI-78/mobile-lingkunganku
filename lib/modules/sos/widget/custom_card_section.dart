import 'package:flutter/material.dart';

import '../../../misc/colors.dart';

Widget customCardSection({
  required String icon,
  required String label,
  required VoidCallback onTap, // Menambahkan parameter onTap
}) {
  return GestureDetector(
    onTap: onTap, // Menentukan aksi saat opsi ditekan
    child: Stack(
      children: [
        // Kontainer latar belakang putih
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.whiteColor.withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textColor2,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Intel',
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),

        // Kontainer hijau di bagian atas
        Positioned(
          top: 10,
          left: 10,
          right: 10,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.buttonColor2,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),

        // Lingkaran putih di belakang avatar
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: CircleAvatar(
            radius: 35,
            backgroundColor: AppColors.textColor1,
            child: Image.asset(
              icon,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      ],
    ),
  );
}
