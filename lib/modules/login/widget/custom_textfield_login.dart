import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/login_cubit.dart';

import '../../../misc/colors.dart';

List<Widget> customTextfieldsLogin() {
  return [
    _buildTextField(label: 'Alamat Email'),
    _buildPasswordField(label: 'Password'),
  ];
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

Widget _buildPasswordField({required String label}) {
  return BlocBuilder<LoginCubit, LoginState>(
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
                obscureText:
                    state.isPasswordObscured, // only use this for one password
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(color: AppColors.buttonColor1),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  suffixIcon: IconButton(
                    icon: Icon(
                      state.isPasswordObscured
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.buttonColor1,
                    ),
                    onPressed: () {
                      // Toggle password visibility
                      context.read<LoginCubit>().togglePasswordVisibility();
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
