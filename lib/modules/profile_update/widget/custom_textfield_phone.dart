import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../misc/text_style.dart';
import '../cubit/profile_update_cubit.dart';

import '../../../misc/colors.dart';

class CustomTextfieldPhone extends StatelessWidget {
  const CustomTextfieldPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileUpdateCubit, ProfileUpdateState>(
      builder: (context, state) {
        // final user = state.profile;
        return _buildTextFormField(
          label: 'Nomor Telepon',
          onChanged: (value) {
            var cubit = context.read<ProfileUpdateCubit>();
            cubit.copyState(newState: cubit.state.copyWith(phone: value));
          },
        );
      },
    );
  }
}

Widget _buildTextFormField({
  required String label,
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.phone,
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
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.whiteColor),
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: AppTextStyles.textProfileNormal,
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
