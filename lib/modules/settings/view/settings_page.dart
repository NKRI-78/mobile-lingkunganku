import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/modules/app/bloc/app_bloc.dart';
import 'package:mobile_lingkunganku/router/builder.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: AppTextStyles.textStyle1,
        ),
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.buttonColor2,
            size: 32,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text('Notification'),
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {
                          // Handle perubahan notifikasi
                        },
                        activeColor: AppColors.whiteColor,
                        activeTrackColor: AppColors.textColor1,
                      ),
                    ),
                    _divider(),
                    ListTile(
                      title: Text('Bahasa'),
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {
                          // Handle perubahan bahasa
                        },
                        activeColor: AppColors.whiteColor,
                        activeTrackColor: AppColors.textColor1,
                      ),
                    ),
                    _divider(),
                    ListTile(
                      title: Text('Location'),
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {
                          // Handle perubahan lokasi
                        },
                        activeColor: AppColors.whiteColor,
                        activeTrackColor: AppColors.textColor1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _logoutButton(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Divider untuk memisahkan setiap pengaturan
  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(
        color: Colors.grey.shade400,
        thickness: 1,
      ),
    );
  }

  /// Tombol Logout dengan konfirmasi
  Widget _logoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Warna tombol logout
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          _showLogoutDialog(context);
        },
        child: Text(
          "Logout",
          style: AppTextStyles.textStyle1.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  /// Menampilkan konfirmasi logout
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Apakah Anda yakin ingin logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text("Batal", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Tutup dialog
                context.read<AppBloc>().add(SetUserLogout());
                HomeRoute().go(context);
              },
              child: Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
