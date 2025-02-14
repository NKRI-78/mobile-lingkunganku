import 'package:flutter/material.dart';
import '../../../misc/colors.dart';

class CustomHeaderAvatar extends StatelessWidget {
  final bool showText;
  final bool isLoggedIn;
  final String displayText;
  final String? avatarLink;

  const CustomHeaderAvatar({
    super.key,
    required this.isLoggedIn,
    required this.showText,
    required this.displayText,
    this.avatarLink, // Dibuat opsional
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.textColor1,
          child: ClipOval(
            child: _buildAvatar(),
          ),
        ),
        if (showText) ...[
          const SizedBox(height: 8),
          Text(
            'Hi, $displayText',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ]
      ],
    );
  }

  Widget _buildAvatar() {
    if (isLoggedIn && avatarLink != null && avatarLink!.isNotEmpty) {
      return Image.network(
        avatarLink!,
        fit: BoxFit.cover,
        width: 100,
        height: 100,
        errorBuilder: (context, error, stackTrace) => _defaultAvatar(),
      );
    }
    return _defaultAvatar();
  }

  Widget _defaultAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.textColor1,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person,
        size: 60,
        color: Colors.white,
      ),
    );
  }
}
