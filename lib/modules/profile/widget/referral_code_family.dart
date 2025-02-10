import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import '../cubit/profile_cubit.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class ReferralCodeFamily extends StatelessWidget {
  const ReferralCodeFamily({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.whiteColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Referral Code Family",
                          style: AppTextStyles.textProfileNormal,
                        ),
                        Text(
                          state.profile?.family?.referral ?? "Tidak Tersedia",
                          style: AppTextStyles.textProfileBold,
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.copy,
                        color: AppColors.whiteColor,
                      ),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(
                              text: state.profile?.family?.referral ??
                                  "Tidak Tersedia"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Kode referral berhasil disalin!",
                              style: AppTextStyles.textProfileNormal,
                            ),
                            backgroundColor: AppColors.secondaryColor,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
