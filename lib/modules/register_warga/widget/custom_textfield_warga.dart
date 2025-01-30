import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../cubit/register_warga_cubit.dart';

List<Widget> customTextfieldsWarga(BuildContext context) {
  return [
    _buildTextField(label: 'Nama Lengkap'),
    _buildTextField(label: 'Alamat Email'),
    _buildTextField(label: 'No Handphone', keyboardType: TextInputType.phone),
    _buildTextField(label: 'Detail Alamat', maxLines: 4),
    _buildPasswordField(label: 'Password'),
    _buildPasswordField(label: 'Konfirmasi Password'),
    _buildTextField(label: 'Referal Code'),
  ];
}

// Password field widget updated to use cubit state
Widget _buildPasswordField({required String label}) {
  return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
    builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.whiteColor),
              ),
              child: TextField(
                obscureText: label == 'Password'
                    ? state.isPasswordObscured
                    : state.isConfirmPasswordObscured,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(color: AppColors.buttonColor1),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  suffixIcon: IconButton(
                    icon: Icon(
                      label == 'Password'
                          ? (state.isPasswordObscured
                              ? Icons.visibility_off
                              : Icons.visibility)
                          : (state.isConfirmPasswordObscured
                              ? Icons.visibility_off
                              : Icons.visibility),
                      color: AppColors.buttonColor1,
                    ),
                    onPressed: () {
                      if (label == 'Password') {
                        context
                            .read<RegisterWargaCubit>()
                            .togglePasswordVisibility();
                      } else {
                        context
                            .read<RegisterWargaCubit>()
                            .toggleConfirmPasswordVisibility();
                      }
                    },
                  ),
                ),
                style: TextStyle(color: AppColors.textColor2),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildTextField({
  required String label,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  int maxLines = 1,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.whiteColor),
          ),
          child: TextField(
            maxLines: maxLines,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: AppColors.buttonColor1),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            ),
            style: TextStyle(color: AppColors.textColor2),
          ),
        ),
      ),
    ),
  );
}
