import 'package:flutter/material.dart';

import '../../../misc/colors.dart';

class CustomHeaderAvatar extends StatelessWidget {
  final bool showText;
  final bool isLoggedIn;
  final String displayText;

  const CustomHeaderAvatar({
    super.key,
    required this.isLoggedIn,
    required this.showText,
    required this.displayText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.textColor1,
          child: ClipOval(
            child: isLoggedIn
                ? Image.asset(
                    'assets/icons/user_avatar.png',
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  )
                : Icon(
                    Icons.person,
                    size: 60,
                    color: AppColors.whiteColor,
                  ),
          ),
        ),
        if (showText) ...[
          const SizedBox(height: 8),
          Text(
            'Hi $displayText,',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ]
      ],
    );
  }
}
