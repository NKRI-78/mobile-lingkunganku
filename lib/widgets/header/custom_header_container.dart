import 'package:flutter/material.dart';
import '../../misc/text_style.dart';
import '../../../misc/colors.dart';
import 'custom_header_avatar.dart';

class CustomHeaderContainer extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationPressed;
  final String? title;
  final bool showText;

  final List<Widget> children;

  const CustomHeaderContainer({
    super.key,
    this.onBackPressed,
    this.onMenuPressed,
    this.onNotificationPressed,
    this.title,
    this.children = const [],
    required this.showText,
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
              // **Tombol Back / Menu di Kiri**
              if (onBackPressed != null || onMenuPressed != null)
                _buildIconButton(
                  icon: onBackPressed != null
                      ? Icons.arrow_back_ios_new
                      : Icons.menu,
                  onPressed: onBackPressed ?? onMenuPressed!,
                )
              else
                const SizedBox(width: 48),

              // **Title di Tengah**
              if (title != null)
                Expanded(
                  child: Text(
                    title!,
                    style: AppTextStyles.textRegister2,
                    textAlign: TextAlign.center,
                  ),
                )
              else
                const Spacer(),

              // **Tombol Notifikasi di Kanan**
              if (onNotificationPressed != null)
                Stack(
                  children: [
                    _buildIconButton(
                      icon: Icons.notifications_on_outlined,
                      onPressed: onNotificationPressed!,
                    ),
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
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
                )
              else
                const SizedBox(width: 48),
            ],
          ),
          CustomHeaderAvatarPage(
            showText: showText,
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  /// Fungsi untuk membangun tombol dengan dekorasi
  Widget _buildIconButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return Container(
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
        icon:
            Icon(icon, color: AppColors.blackColor.withOpacity(0.7), size: 32),
        onPressed: onPressed,
      ),
    );
  }
}
