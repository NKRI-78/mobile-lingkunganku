import 'package:flutter/material.dart';
import '../../../misc/colors.dart';

class CustomHeaderAvatar extends StatelessWidget {
  const CustomHeaderAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.textColor1,
          child: Icon(
            Icons.person,
            size: 60,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Hi User,',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
