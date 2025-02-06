import 'package:flutter/material.dart';

import '../../../misc/colors.dart';

Widget customCardSection({
  required String icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      children: [
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
              const SizedBox(height: 10),
            ],
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          right: 10,
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.buttonColor2,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        Center(
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.textColor1,
            child: Image.asset(
              icon,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      ],
    ),
  );
}
