import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/modules/app/bloc/app_bloc.dart';
import 'package:mobile_lingkunganku/router/builder.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text("Konfirmasi Logout"),
        content: Text("Apakah Anda yakin ingin logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text("Batal",
                style: TextStyle(color: AppColors.secondaryColor)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext); // Tutup dialog
              Navigator.pop(context); // Tutup drawer
              getIt<AppBloc>().add(SetUserLogout()); // Logout
              HomeRoute().go(context); // Kembali ke Home
            },
            child: Text("Logout", style: TextStyle(color: AppColors.redColor)),
          ),
        ],
      );
    },
  );
}
