import 'package:flutter/material.dart';

import '../../../misc/colors.dart'; // Import warna yang diperlukan

class CustomButton extends StatelessWidget {
  final String text; // Teks yang akan ditampilkan di tombol
  final VoidCallback onPressed; // Callback untuk tombol
  final Color backgroundColor; // Warna background tombol
  final Color textColor; // Warna teks tombol
  final double horizontalPadding; // Padding horizontal
  final double verticalPadding; // Padding vertikal
  final IconData? icon; // Ikon opsional
  final double iconSize; // Ukuran ikon

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.textColor2, // Default warna background
    this.textColor = Colors.white, // Default warna teks
    this.horizontalPadding = 35, // Default padding horizontal
    this.verticalPadding = 15, // Default padding vertikal
    this.icon, // Default null jika tidak ada ikon
    this.iconSize = 24.0, // Default ukuran ikon
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min, // Agar ukuran tombol sesuai konten
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) // Jika ikon tersedia, tambahkan
            Icon(
              icon,
              size: iconSize,
              color: textColor,
            ),
          if (icon != null)
            const SizedBox(width: 8), // Jarak antara ikon dan teks
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
