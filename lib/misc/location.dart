import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'colors.dart';
import 'text_style.dart';

Future<Position> determinePosition(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Cek apakah layanan lokasi aktif
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    // Permintaan pertama
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Permintaan kedua jika user menolak pertama kali
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Jika user menolak lagi, tampilkan dialog ke pengaturan
        showPermissionDialog(context);
        return Future.error('Location permissions are permanently denied');
      }
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Jika user langsung menolak selamanya, tampilkan dialog
    showPermissionDialog(context);
    return Future.error('Location permissions are permanently denied');
  }

  // Izin diberikan, ambil lokasi pengguna
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.bestForNavigation,
  );
}

void showPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          title: Text(
            textAlign: TextAlign.center,
            'Izin Lokasi Diperlukan!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 60,
                color: AppColors.secondaryColor,
              ),
              Text(
                'Izin lokasi diperlukan agar aplikasi dapat berfungsi dengan baik. '
                'Harap aktifkan izin lokasi di pengaturan aplikasi.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    openAppSettings();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      'Ke Pengaturan',
                      style: AppTextStyles.textProfileBold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
