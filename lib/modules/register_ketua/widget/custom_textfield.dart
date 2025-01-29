import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../misc/colors.dart';
import '../view/register_ketua_page.dart';

List<Widget> customTextfields() {
  return [
    _buildTextField(label: 'Nama Lengkap'),
    _buildTextField(label: 'Alamat Email'),
    _buildTextField(
      label: 'No Handphone',
      keyboardType: TextInputType.phone,
    ),
    _buildTextField(label: 'Nama Lingkungan / Perumahan'),
    _buildTextField(label: 'Detail Alamat'),
    _buildTextField(
      label: 'Berapa Banyak Penghuni (max. 50 KK)',
      keyboardType: TextInputType.number,
    ),
    // PIN POINT MAPS
    const InputLocationLabel(),
    const InputLocation(),
    SizedBox(height: 20),

    _buildTextField(label: 'Password', obscureText: true),
    _buildTextField(label: 'Confirm Password', obscureText: true),
  ];
}

Widget _buildTextField({
  required String label,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.whiteColor),
          ),
          child: TextField(
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: AppColors.buttonColor1),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            style: TextStyle(color: AppColors.textColor2),
          ),
        ),
      ),
    ),
  );
}
