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
            height: 65,
            decoration: BoxDecoration(
              color: AppColors.buttonColor2,
              borderRadius: BorderRadius.circular(24),
            ),
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/forum.png',
                      width: 30, height: 35),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/iuran.png',
                      width: 30, height: 35),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/pulsa.png',
                      width: 65, height: 35),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/event.png',
                      width: 30, height: 35),
                  label: '',
                ),
                const BottomNavigationBarItem(
                  icon: SizedBox.shrink(),
                  label: '',
                ),
              ],
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              showUnselectedLabels: false,
              showSelectedLabels: false,
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
                if (index == 1) {
                  IuranRoute().go(context);
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
          right: -3,
          bottom: -3,
          child: GestureDetector(
            onTap: () => onTap(4),
            child: Container(
              width: 75,
              height: 75,
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
