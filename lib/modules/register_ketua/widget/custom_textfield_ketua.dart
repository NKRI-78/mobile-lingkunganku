import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../cubit/register_ketua_cubit.dart';
import '../view/register_ketua_page.dart';

class CustomTextfieldKetua extends StatelessWidget {
  const CustomTextfieldKetua({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FieldName(),
        _FieldEmail(),
        _FieldPhone(),
        _FieldNeighborhood(),
        _FieldDetailAddress(),
        const InputLocationLabel(),
        const InputLocation(),
        _FieldPassword(),
        _FieldConfirmPassword(),
      ],
    );
  }
}

class _FieldName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterKetuaCubit, RegisterKetuaState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return _buildTextFormField(
          label: 'Nama Lengkap',
          onChanged: (value) {
            context.read<RegisterKetuaCubit>().copyState(
                newState: context
                    .read<RegisterKetuaCubit>()
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
    return BlocBuilder<RegisterKetuaCubit, RegisterKetuaState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return _buildTextFormField(
          label: 'Alamat Email',
          onChanged: (value) {
            var cubit = context.read<RegisterKetuaCubit>();
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
    return BlocBuilder<RegisterKetuaCubit, RegisterKetuaState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return _buildTextFormField(
          label: 'No Handphone',
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            var cubit = context.read<RegisterKetuaCubit>();
            cubit.copyState(newState: cubit.state.copyWith(phone: value));
          },
        );
      },
    );
  }
}

class _FieldNeighborhood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterKetuaCubit, RegisterKetuaState>(
      buildWhen: (previous, current) =>
          previous.neighborhoodName != current.neighborhoodName,
      builder: (context, state) {
        return _buildTextFormField(
          label: 'Nama Lingkungan / Komplek',
          onChanged: (value) {
            var cubit = context.read<RegisterKetuaCubit>();
            cubit.copyState(
                newState: cubit.state.copyWith(neighborhoodName: value));
          },
        );
      },
    );
  }
}

class _FieldDetailAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterKetuaCubit, RegisterKetuaState>(
      buildWhen: (previous, current) =>
          previous.detailAddress != current.detailAddress,
      builder: (context, state) {
        return _buildTextFormField(
          label: 'Detail Alamat',
          maxLines: 4,
          onChanged: (value) {
            var cubit = context.read<RegisterKetuaCubit>();
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
    return BlocBuilder<RegisterKetuaCubit, RegisterKetuaState>(
      builder: (context, state) {
        bool isObscured = state.isPasswordObscured;
        return _buildPasswordField(
          label: 'Password',
          onChanged: (value) {
            var cubit = context.read<RegisterKetuaCubit>();
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
    return BlocBuilder<RegisterKetuaCubit, RegisterKetuaState>(
      builder: (context, state) {
        bool isObscured = state.isConfirmPasswordObscured;
        return _buildPasswordField(
          label: 'Konfirmasi Password',
          onChanged: (value) {
            var cubit = context.read<RegisterKetuaCubit>();
            cubit.copyState(
                newState: cubit.state.copyWith(passwordConfirm: value));
          },
          isObscured: isObscured,
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
            textCapitalization: (label == 'Nama Lengkap' ||
                    label == 'Nama Lingkungan / Komplek' ||
                    label == 'Detail Alamat')
                ? TextCapitalization.words
                : TextCapitalization.none,
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
          child: BlocBuilder<RegisterKetuaCubit, RegisterKetuaState>(
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
                            .read<RegisterKetuaCubit>()
                            .togglePasswordVisibility();
                      } else {
                        context
                            .read<RegisterKetuaCubit>()
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
