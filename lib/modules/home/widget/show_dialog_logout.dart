import 'package:flutter/material.dart';
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
        title: const Text("Konfirmasi Logout"),
        content: const Text("Apakah Anda yakin ingin logout?"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  child: const Text("Batal",
                      style: TextStyle(color: AppColors.whiteColor)),
                ),
              ),
              const SizedBox(width: 10),
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
                  child: const Text("Logout",
                      style: TextStyle(color: AppColors.whiteColor)),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
