import 'package:flutter/material.dart';

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
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  color: Colors.grey.shade400,
                  thickness: 1,
                ),
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  color: Colors.grey.shade400,
                  thickness: 1,
                ),
              ),
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
      ),
    );
  }
}
