import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';
import 'package:mobile_lingkunganku/modules/profile/cubit/profile_cubit.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../router/builder.dart';
import '../../app/bloc/app_bloc.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text("Konfirmasi LogOut"),
        content: const Text("Apakah Anda yakin ingin logout?"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text(
                    "Batal",
                    style: AppTextStyles.textProfileBold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(dialogContext); // Tutup dialog
                    Navigator.pop(context); // Tutup drawer
                    getIt<AppBloc>().add(SetUserLogout()); // Logout
                    getIt<ProfileCubit>().getProfile();
                    HomeRoute().go(context);
                  },
                  child: Text(
                    "LogOut",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.textProfileBold,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
