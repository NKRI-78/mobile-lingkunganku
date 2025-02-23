import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../misc/text_style.dart';
import '../cubit/profile_update_cubit.dart';
import '../../../misc/colors.dart';

class CustomTextfieldPhone extends StatelessWidget {
  const CustomTextfieldPhone({super.key, required this.ctrPhone});

  final TextEditingController ctrPhone;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileUpdateCubit, ProfileUpdateState>(
      builder: (context, state) {
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
                  maxLength: 13,
                  controller: ctrPhone,
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Nomor Telepon',
                    labelStyle: AppTextStyles.textProfileNormal,
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  ),
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
