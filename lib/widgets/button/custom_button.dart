import 'package:flutter/material.dart';
import '../../../misc/colors.dart';

class CustomButton extends StatelessWidget {
  final String text; // Teks tombol
  final void Function()? onPressed; // Callback tombol
  final Color backgroundColor; // Warna background tombol
  final Color textColor; // Warna teks tombol
  final double horizontalPadding; // Padding horizontal
  final double verticalPadding; // Padding vertikal
  final IconData? icon; // Ikon opsional
  final double iconSize; // Ukuran ikon
  final bool isLoading; // Status loading

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.textColor2,
    this.textColor = Colors.white,
    this.horizontalPadding = 35,
    this.verticalPadding = 15,
    this.icon,
    this.iconSize = 24.0,
    this.isLoading = false,
    SizedBox? child,
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
      onPressed: isLoading ? null : onPressed, // Disable tombol saat loading
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: iconSize,
                    color: textColor,
                  ),
                if (icon != null) const SizedBox(width: 8),
                Text(
                  text,
                  textAlign: TextAlign.center,
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
