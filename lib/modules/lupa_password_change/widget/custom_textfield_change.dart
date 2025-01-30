import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../cubit/lupa_password_change_cubit.dart';

List<Widget> customTextfieldsChange() {
  return [
    _buildPasswordField(label: 'Password'),
    _buildPasswordField(label: 'Konfirmasi Password'),
  ];
}

Widget _buildPasswordField({required String label}) {
  return BlocBuilder<LupaPasswordChangeCubit, LupaPasswordChangeState>(
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
                            .read<LupaPasswordChangeCubit>()
                            .togglePasswordVisibility();
                      } else {
                        context
                            .read<LupaPasswordChangeCubit>()
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
