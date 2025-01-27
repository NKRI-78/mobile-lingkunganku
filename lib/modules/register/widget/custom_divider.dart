import 'package:flutter/material.dart';

import '../../../misc/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.whiteColor,
            thickness: 1.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Jika sudah memiliki Akun',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: 'Intel',
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.whiteColor,
            thickness: 1.5,
          ),
        ),
      ],
    );
  }
}
