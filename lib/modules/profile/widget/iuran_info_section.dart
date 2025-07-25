import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../../misc/price_currency.dart';
import '../../../misc/text_style.dart';
import '../../../router/builder.dart';
import '../cubit/profile_cubit.dart';

class IuranInfoSection extends StatelessWidget {
  const IuranInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final user = state.profile;

        if (user == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
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
                        "Saldo Kas Lingkungan",
                        style: AppTextStyles.textProfileNormal,
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.secondaryColor,
                        ),
                        child: IconButton(
                          icon: Image.asset("assets/icons/doc.png"),
                          onPressed: () {
                            IuranInfoRoute().go(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    Price.currency(
                        (user.neighborhood!.balance ?? 0).toDouble()),
                    style: AppTextStyles.textProfileBold,
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
