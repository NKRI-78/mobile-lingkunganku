import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../cubit/profile_update_cubit.dart';

class CustomTextfieldName extends StatelessWidget {
  const CustomTextfieldName({super.key, required this.ctrName});
  final TextEditingController ctrName;

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
                  controller: ctrName,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    labelStyle: AppTextStyles.textProfileNormal,
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
}
