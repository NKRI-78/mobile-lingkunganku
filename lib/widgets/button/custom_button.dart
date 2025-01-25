import 'package:flutter/material.dart';
import '../../../misc/colors.dart'; // Import warna yang diperlukan

class CustomButton extends StatelessWidget {
  final String text; // Teks yang akan ditampilkan di tombol
  final VoidCallback onPressed; // Callback untuk tombol
  final Color backgroundColor; // Warna background tombol
  final Color textColor; // Warna teks tombol
  final double horizontalPadding; // Padding horizontal
  final double verticalPadding; // Padding vertikal

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.textColor2, // Default warna background
    this.textColor = Colors.white, // Default warna teks
    this.horizontalPadding = 35, // Default padding horizontal
    this.verticalPadding = 15, // Default padding vertikal
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
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
