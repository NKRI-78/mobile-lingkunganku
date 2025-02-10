import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/profile_cubit.dart';
import '../../../router/builder.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final user = state.profile;

        if (user == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

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
                  border: Border.all(color: AppColors.whiteColor, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nama",
                          style: AppTextStyles.textProfileNormal,
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.secondaryColor,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: AppColors.whiteColor,
                              size: 20,
                            ),
                            onPressed: () {
                              ProfileUpdateRoute().go(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                      user.profile?.fullname ?? 'Tidak tersedia',
                      style: AppTextStyles.textProfileBold,
                    ),
                    const SizedBox(height: 8),

                    /// **Email (Tanpa Edit)**
                    Text(
                      "Email",
                      style: AppTextStyles.textProfileNormal,
                    ),
                    Text(
                      user.email ?? 'Tidak tersedia',
                      style: AppTextStyles.textProfileBold,
                    ),
                    const SizedBox(height: 8),

                    /// **Baris Nomor Tlp & Tombol Edit**
                    Text(
                      "Nomor Tlp",
                      style: AppTextStyles.textProfileNormal,
                    ),
                    Text(
                      user.phone ?? 'Tidak tersedia',
                      style: AppTextStyles.textProfileBold,
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
