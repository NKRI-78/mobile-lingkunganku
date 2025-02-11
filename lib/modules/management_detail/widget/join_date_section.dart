import 'package:flutter/material.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class JoinDateSection extends StatelessWidget {
  const JoinDateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              'Bergabung Sejak',
              style: AppTextStyles.textWelcome,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Flexible(
            child: Text(
              "25 Januari 2024",
              style: AppTextStyles.textStyle2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
