import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../misc/colors.dart';

class CustomHeaderAvatar extends StatelessWidget {
  final bool showText;
  final bool isLoggedIn;
  final bool isLoading;
  final String displayText;
  final String? avatarLink;

  const CustomHeaderAvatar({
    super.key,
    required this.isLoggedIn,
    required this.showText,
    required this.displayText,
    required this.isLoading,
    this.avatarLink,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Jika masih loading, tampilkan shimmer
        if (isLoading)
          _buildShimmerAvatar()
        else if (isLoggedIn && avatarLink != null && avatarLink!.isNotEmpty)
          _buildNetworkAvatar() // Jika login & ada avatar, tampilkan avatar
        else
          _buildDefaultAvatar(), // Jika belum login, tampilkan default avatar

        const SizedBox(height: 5),

        // Tampilkan teks "Hi, User" atau nama pengguna
        if (showText)
          isLoading
              ? _buildShimmerText() // Jika loading, tampilkan shimmer
              : _buildUserText(), // Jika sudah selesai, tampilkan teks
      ],
    );
  }

  /// **Shimmer Effect untuk Avatar**
  Widget _buildShimmerAvatar() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  /// **Menampilkan Avatar dari Network**
  Widget _buildNetworkAvatar() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: AppColors.textColor1,
      child: ClipOval(
        child: Image.network(
          avatarLink!,
          fit: BoxFit.cover,
          width: 100,
          height: 100,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildShimmerAvatar(); // Jika masih loading, tampilkan shimmer
          },
          errorBuilder: (context, error, stackTrace) {
            return _buildDefaultAvatar(); // Jika error, tampilkan default avatar
          },
        ),
      ),
    );
  }

  /// **Avatar Default (Jika Belum Login)**
  Widget _buildDefaultAvatar() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: AppColors.textColor1,
      child: const Icon(
        Icons.person,
        size: 50,
        color: Colors.white,
      ),
    );
  }

  /// **Shimmer Effect untuk Teks**
  Widget _buildShimmerText() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 120,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// **Menampilkan Nama Pengguna atau "Hi, User"**
  Widget _buildUserText() {
    final String textToShow =
        isLoggedIn && displayText.isNotEmpty ? 'Hi, $displayText' : 'Hi, User';

    return Text(
      textToShow,
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
