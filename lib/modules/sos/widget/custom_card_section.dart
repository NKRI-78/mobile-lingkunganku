import 'package:flutter/material.dart';
import '../../../misc/colors.dart';

Widget customCardSection({
  required String icon,
  required String label,
  required VoidCallback onTap,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      double screenWidth = MediaQuery.of(context).size.width;
      double cardWidth = screenWidth * 0.9; // 90% dari lebar layar
      double cardHeight = screenWidth * 0.35; // Proporsional tinggi

      double iconSize = screenWidth * 0.1; // Ukuran ikon sesuai layar
      double circleSize = screenWidth * 0.15; // Lingkaran ikon

      return GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: cardHeight,
              width: cardWidth,
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
                      fontSize: screenWidth * 0.035, // Ukuran teks responsif
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Intel',
                    ),
                  ),
                  const SizedBox(height: 3),
                ],
              ),
            ),
            Positioned(
              top: cardHeight * 0.1,
              left: cardWidth * 0.05,
              right: cardWidth * 0.05,
              child: Container(
                height: cardHeight * 0.4,
                decoration: BoxDecoration(
                  color: AppColors.buttonColor2,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            Container(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
              ),
            ),
            CircleAvatar(
              radius: circleSize * 0.45,
              backgroundColor: AppColors.textColor1,
              child: Image.asset(
                icon,
                height: iconSize,
                width: iconSize,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    },
  );
}
