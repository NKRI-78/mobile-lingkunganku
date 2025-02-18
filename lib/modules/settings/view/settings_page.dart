import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isLocationEnabled = false; // Nilai default

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  // Fungsi untuk memeriksa status izin lokasi
  Future<void> _checkLocationPermission() async {
    var status = await Permission.location.status;
    setState(() {
      _isLocationEnabled = status.isGranted; // Jika granted, nyalakan switch
    });
  }

  // Fungsi untuk mengubah status izin lokasi
  Future<void> _toggleLocationPermission(bool newValue) async {
    if (newValue) {
      var result = await Permission.location.request();
      if (result.isGranted) {
        setState(() {
          _isLocationEnabled = true;
        });
      } else {
        setState(() {
          _isLocationEnabled = false;
        });
      }
    } else {
      openAppSettings(); // Arahkan ke pengaturan jika user ingin mematikan izin
    }
  }

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
                      title: Text('Notifikasi'),
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {},
                        activeColor: AppColors.whiteColor,
                        activeTrackColor: AppColors.textColor1,
                      ),
                    ),
                    _divider(),
                    ListTile(
                      title: Text('Bahasa'),
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {},
                        activeColor: AppColors.whiteColor,
                        activeTrackColor: AppColors.textColor1,
                      ),
                    ),
                    _divider(),
                    ListTile(
                      title: Text('Lokasi'),
                      trailing: Switch(
                        value: _isLocationEnabled,
                        onChanged: (value) => _toggleLocationPermission(value),
                        activeColor: AppColors.whiteColor,
                        activeTrackColor: AppColors.textColor1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(
        color: Colors.grey.shade400,
        thickness: 1,
      ),
    );
  }
}
