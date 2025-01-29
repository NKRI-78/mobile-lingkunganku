import 'package:flutter/material.dart';

import '../../../misc/colors.dart';

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.buttonColor2,
          borderRadius: BorderRadius.circular(32),
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
              icon: Icon(Icons.sos),
              label: 'SOS',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent, // Pastikan transparan
          elevation: 0, // Hilangkan shadow
          selectedItemColor: AppColors.unselectColor,
          unselectedItemColor: AppColors.unselectColor,
          currentIndex: currentIndex,
          onTap: onTap,
        ),
      ),
    );
  }
}
