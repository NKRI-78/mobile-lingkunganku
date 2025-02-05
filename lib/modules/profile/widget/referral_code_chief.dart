import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../profile/cubit/profile_cubit.dart';

class ReferralCodeChief extends StatelessWidget {
  const ReferralCodeChief({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          // Menampilkan pesan error yang didapat dari API
          return Center(child: Text("Error: ${state.errorMessage}"));
        }

        final referralCode = state.chiefReferral.isNotEmpty
            ? state.chiefReferral
            : 'Tidak tersedia';

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
                          "Referral Code Warga",
                          style: AppTextStyles.textProfileNormal,
                        ),
                        Text(
                          referralCode,
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
                          ClipboardData(text: referralCode),
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
