import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../cubit/register_warga_cubit.dart';

class CustomTextfieldWarga extends StatelessWidget {
  const CustomTextfieldWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FieldName(),
        _FieldEmail(),
        _FieldPhone(),
        _FieldDetailAddress(),
        _FieldPassword(),
        _FieldConfirmPassword(),
        _FieldReferalCode(),
      ],
    );
  }
}

class _FieldName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return _buildTextFormField(
          label: 'Nama Lengkap',
          onChanged: (value) {
            context.read<RegisterWargaCubit>().copyState(
                newState: context
                    .read<RegisterWargaCubit>()
                    .state
                    .copyWith(name: value));
          },
        );
      },
    );
  }
}

class _FieldEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return _buildTextFormField(
          label: 'Alamat Email',
          onChanged: (value) {
            var cubit = context.read<RegisterWargaCubit>();
            cubit.copyState(newState: cubit.state.copyWith(email: value));
          },
        );
      },
    );
  }
}

class _FieldPhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return _buildTextFormField(
          label: 'No Handphone',
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            var cubit = context.read<RegisterWargaCubit>();
            cubit.copyState(newState: cubit.state.copyWith(phone: value));
          },
        );
      },
    );
  }
}

class _FieldDetailAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      buildWhen: (previous, current) =>
          previous.detailAddress != current.detailAddress,
      builder: (context, state) {
        return _buildTextFormField(
          label: 'Detail Alamat',
          maxLines: 4,
          onChanged: (value) {
            var cubit = context.read<RegisterWargaCubit>();
            cubit.copyState(
                newState: cubit.state.copyWith(detailAddress: value));
          },
        );
      },
    );
  }
}

class _FieldPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      builder: (context, state) {
        bool isObscured = state.isPasswordObscured;
        return _buildPasswordField(
          label: 'Password',
          onChanged: (value) {
            var cubit = context.read<RegisterWargaCubit>();
            cubit.copyState(newState: cubit.state.copyWith(password: value));
          },
          isObscured: isObscured,
        );
      },
    );
  }
}

class _FieldConfirmPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      builder: (context, state) {
        bool isObscured = state.isConfirmPasswordObscured;
        return _buildPasswordField(
          label: 'Konfirmasi Password',
          onChanged: (value) {
            var cubit = context.read<RegisterWargaCubit>();
            cubit.copyState(
                newState: cubit.state.copyWith(passwordConfirm: value));
          },
          isObscured: isObscured,
        );
      },
    );
  }
}

class _FieldReferalCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      builder: (context, state) {
        return _buildTextFormField(
          label: 'Referal Code',
          onChanged: (value) {
            var cubit = context.read<RegisterWargaCubit>();
            cubit.copyState(newState: cubit.state.copyWith(referral: value));
          },
        );
      },
    );
  }
}

Widget _buildTextFormField({
  required String label,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  int maxLines = 1,
  required ValueChanged<String> onChanged,
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
          child: TextFormField(
            maxLines: maxLines,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
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

Widget _buildPasswordField({
  required String label,
  required ValueChanged<String> onChanged,
  required bool isObscured,
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
          child: BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
            builder: (context, state) {
              return TextFormField(
                obscureText: isObscured,
                onChanged: onChanged,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(color: AppColors.buttonColor1),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.buttonColor1,
                    ),
                    onPressed: () {
                      // Ensure context is available and update visibility through Cubit
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
              );
            },
          ),
        ),
      ),
    ),
  );
}
