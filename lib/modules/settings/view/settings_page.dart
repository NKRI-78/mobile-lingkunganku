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
  bool _isLocationEnabled = false;
  bool _isNotificationEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  // Memeriksa status izin lokasi dan notifikasi
  Future<void> _checkPermissions() async {
    var locationStatus = await Permission.location.status;
    var notificationStatus = await Permission.notification.status;

    setState(() {
      _isLocationEnabled = locationStatus.isGranted;
      _isNotificationEnabled = notificationStatus.isGranted;
    });
  }

  // Mengatur izin lokasi
  Future<void> _toggleLocationPermission(bool newValue) async {
    if (newValue) {
      var result = await Permission.location.request();
      setState(() {
        _isLocationEnabled = result.isGranted;
      });
    } else {
      openAppSettings();
    }
  }

  // Mengatur izin notifikasi
  Future<void> _toggleNotificationPermission(bool newValue) async {
    if (newValue) {
      var result = await Permission.notification.request();
      setState(() {
        _isNotificationEnabled = result.isGranted;
      });
    } else {
      openAppSettings();
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
            size: 24,
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
                        value: _isNotificationEnabled,
                        onChanged: (value) =>
                            _toggleNotificationPermission(value),
                        activeColor: AppColors.whiteColor,
                        activeTrackColor: AppColors.textColor1,
                      ),
                    ),
                    // _divider(),
                    // ListTile(
                    //   title: Text('Bahasa'),
                    //   trailing: Switch(
                    //     value: false,
                    //     onChanged: (value) {},
                    //     activeColor: AppColors.whiteColor,
                    //     activeTrackColor: AppColors.textColor1,
                    //   ),
                    // ),
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
