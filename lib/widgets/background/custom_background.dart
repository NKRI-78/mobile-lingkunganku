import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  final String? imagePath; // Parameter opsional untuk custom image

  const CustomBackground({
    super.key,
    this.imagePath, // Jika tidak disediakan, gunakan gambar default
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath ??
          'assets/images/bg.png', // Gunakan gambar default jika imagePath null
      fit: BoxFit.cover,
      width: double.infinity, // Menutupi lebar layar
      height: double.infinity, // Menutupi tinggi layar
    );
  }
}
