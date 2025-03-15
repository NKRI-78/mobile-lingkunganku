import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/profile_cubit.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class NomorKeamananSection extends StatelessWidget {
  const NomorKeamananSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.whiteColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nomor Keamanan",
                        style: AppTextStyles.textProfileNormal,
                      ),
                      Text(
                        state.profile?.neighborhood?.phoneSecurity ??
                            "Tidak Tersedia",
                        style: AppTextStyles.textProfileBold,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.whiteColor,
                    ),
                    onPressed: () {
                      //
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
