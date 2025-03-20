import 'package:badges/badges.dart' as Badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../misc/text_style.dart';
import '../../modules/app/bloc/app_bloc.dart';
import 'custom_header_avatar.dart';

class CustomHeaderContainer extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationPressed;
  final String? title;
  final bool showText;
  final bool showAvatar;
  final bool isLoggedIn;
  final bool isLoading;
  final String displayText;
  final String? avatarLink;
  final List<Widget> children;
  final bool isHomeOrPublic;

  const CustomHeaderContainer({
    super.key,
    required this.displayText,
    required this.isLoggedIn,
    required this.isLoading,
    this.onBackPressed,
    this.onMenuPressed,
    this.onNotificationPressed,
    this.title,
    this.children = const [],
    required this.showText,
    this.avatarLink,
    this.showAvatar = true,
    required this.isHomeOrPublic,
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
        top: 40,
        bottom: 10,
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

              // **Logo Jika Home/Public, Title Jika Halaman Lain**
              if (isHomeOrPublic)
                Expanded(
                  child: Image.asset(
                    'assets/icons/lingkunganku.png',
                    height: 35,
                  ),
                )
              else if (title != null)
                Expanded(
                  child: Text(
                    title!,
                    style: AppTextStyles.textRegister2,
                    textAlign: TextAlign.center,
                  ),
                )
              else
                const Spacer(),

              if (onNotificationPressed != null)
                BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return Badges.Badge(
                      position: Badges.BadgePosition.topEnd(end: 0),
                      showBadge: state.badges?.unreadCount == null ||
                              state.badges?.unreadCount == 0
                          ? false
                          : true,
                      badgeStyle:
                          const Badges.BadgeStyle(padding: EdgeInsets.all(5)),
                      badgeContent: Text(
                        state.loadingNotif
                            ? '..'
                            : '${state.badges?.unreadCount}',
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      child: _buildIconButton(
                          icon: Icons.notifications_active_outlined,
                          onPressed: onNotificationPressed!),
                    );
                  },
                )
              else
                const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 5),
          // **Menampilkan Avatar hanya jika `showAvatar` == true**
          if (showAvatar)
            CustomHeaderAvatar(
              isLoading: isLoading,
              avatarLink: avatarLink,
              displayText: displayText,
              isLoggedIn: isLoggedIn,
              showText: showText,
            )
          else if (showText) // Jika avatar tidak tampil, tapi text tetap ada
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Hi, $displayText',
                style: AppTextStyles.textRegister2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),

          ...children,
        ],
      ),
    );
  }

  /// Fungsi untuk membangun tombol dengan dekorasi
  Widget _buildIconButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return Container(
      width: 40,
      height: 40,
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
            Icon(icon, color: AppColors.blackColor.withOpacity(0.7), size: 24),
        onPressed: onPressed,
      ),
    );
  }
}
