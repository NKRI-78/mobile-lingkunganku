import 'package:flutter/material.dart';
import '../../../misc/colors.dart';
import 'custom_header_avatar.dart'; // Import CustomHeaderAvatar

class CustomHeaderContainer extends StatelessWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback onNotificationPressed;
  final List<Widget> children; // Parameter untuk widget tambahan

  const CustomHeaderContainer({
    super.key,
    required this.onMenuPressed,
    required this.onNotificationPressed,
    this.children = const [], // Default kosong
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(62),
          bottomRight: Radius.circular(62),
        ),
      ),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 50,
        bottom: 30,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tombol Menu
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: AppColors.blackColor,
                    size: 32,
                  ),
                  onPressed: onMenuPressed,
                ),
              ),
              // Tombol Notifikasi
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.notifications_on_outlined,
                        color: AppColors.blackColor,
                        size: 32,
                      ),
                      onPressed: onNotificationPressed,
                    ),
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: const Text(
                          '5',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const CustomHeaderAvatar(), // Gunakan CustomHeaderAvatar
          const SizedBox(height: 10), // Spasi antara avatar dan teks

          ...children, // Tambahkan widget-widget tambahan di sini
        ],
      ),
    );
  }
}
