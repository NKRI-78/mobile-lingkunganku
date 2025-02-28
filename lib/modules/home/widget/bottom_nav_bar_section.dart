import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../../router/builder.dart';
import '../../app/bloc/app_bloc.dart';

class BottomNavBarSection extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBarSection({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = context.read<AppBloc>().state.isAlreadyLogin;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: AppColors.buttonColor2,
              borderRadius: BorderRadius.circular(24),
            ),
            child: BottomNavigationBar(
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.forum_outlined),
                  label: 'Forum',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.payments_outlined),
                  label: 'Iuran',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.receipt_long_outlined),
                  label: 'Pulsa &\nTagihan',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.event_outlined),
                  label: 'Event',
                ),
                const BottomNavigationBarItem(
                  icon: SizedBox.shrink(),
                  label: '',
                ),
              ],
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedFontSize: 11,
              unselectedFontSize: 11,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              iconSize: 22,
              selectedItemColor: AppColors.unselectColor,
              unselectedItemColor: AppColors.unselectColor,
              currentIndex: currentIndex,
              onTap: (index) {
                if (!isLoggedIn) {
                  RegisterRoute().go(context);
                  return;
                }
                if (index == 0) {
                  ForumRoute().go(context);
                }
                if (index == 3) {
                  EventRoute().go(context);
                } else {
                  onTap(index);
                }
              },
            ),
          ),
        ),

        // Tombol SOS melayang
        Positioned(
          right: -5,
          bottom: 0,
          child: GestureDetector(
            onTap: () => onTap(4),
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Transform.scale(
                scale: 1.5,
                child: Image.asset(
                  'assets/icons/sos.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
