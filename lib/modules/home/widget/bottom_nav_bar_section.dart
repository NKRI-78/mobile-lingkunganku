import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../app/bloc/app_bloc.dart';
import '../widget/show_dialog_register.dart';

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

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: AppColors.buttonColor2,
          borderRadius: BorderRadius.circular(24),
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.forum_outlined),
              label: 'Forum',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payments_outlined),
              label: 'Iuran',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              label: 'Pulsa & Tagihan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_outlined),
              label: 'Event',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sensors_sharp),
              label: 'SOS',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          iconSize: 25,
          selectedItemColor: AppColors.unselectColor,
          unselectedItemColor: AppColors.unselectColor,
          currentIndex: currentIndex,
          onTap: (index) {
            if (!isLoggedIn && index != 4) {
              // Jika belum login dan bukan SOS, tampilkan dialog registrasi
              showRegisterDialog(context);
            } else {
              // Jika sudah login atau tombol SOS ditekan, jalankan navigasi
              onTap(index);
            }
          },
        ),
      ),
    );
  }
}
