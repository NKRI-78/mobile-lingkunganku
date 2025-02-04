import 'package:flutter/material.dart';

import '../../../widgets/background/custom_background.dart';
import '../../../widgets/header/custom_header_container.dart';
import '../widget/profile_info_section.dart';
import '../widget/referral_code_section.dart';
import '../widget/transfer_management_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomBackground(),
          Column(
            children: [
              CustomHeaderContainer(
                title: 'Profile',
                onBackPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      ProfileInfoSection(),
                      TransferManagementSection(),
                      ReferralCodeSection(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
