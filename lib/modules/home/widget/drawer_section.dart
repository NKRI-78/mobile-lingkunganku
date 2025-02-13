import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/text_style.dart';
import '../../../router/builder.dart';
import '../../../widgets/button/custom_button.dart';
import '../../app/bloc/app_bloc.dart';
import '../bloc/home_bloc.dart';
import 'show_dialog_logout.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = getIt<AppBloc>().state;
    final bool isLoggedIn = appState.isAlreadyLogin;
    final role = getIt<HomeBloc>().state.profile?.roleApp ?? '';

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 50),
                children: <Widget>[
                  Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/lingkunganku.png'),
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.textColor1,
                    child: isLoggedIn
                        ? ClipOval(
                            child: Image.asset(
                              'assets/icons/user_avatar.png',
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          )
                        : Icon(Icons.person,
                            size: 60, color: AppColors.whiteColor),
                  ),
                  const SizedBox(height: 40),

                  /// **Container dengan Blur Efek Hanya di Dalamnya**
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          // Efek Blur di dalam Container
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                          // Isi Container
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.whiteColor,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                if (isLoggedIn)
                                  ListTile(
                                    leading: Icon(Icons.person_outline,
                                        color: AppColors.whiteColor),
                                    title: Text("Profile",
                                        style: AppTextStyles.buttonText1),
                                    onTap: () {
                                      ProfileRoute().go(context);
                                    },
                                  ),
                                ListTile(
                                  leading: Icon(Icons.settings_outlined,
                                      color: AppColors.whiteColor),
                                  title: Text("Settings",
                                      style: AppTextStyles.buttonText1),
                                  onTap: () {
                                    SettingsRoute().go(context);
                                  },
                                ),
                                if (isLoggedIn)
                                  if (role != "MEMBER")
                                    ListTile(
                                      leading: Icon(Icons.description_outlined,
                                          color: AppColors.whiteColor),
                                      title: Text("Management",
                                          style: AppTextStyles.buttonText1),
                                      onTap: () {
                                        ManagementRoute().go(context);
                                      },
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isLoggedIn
                ? Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: CustomButton(
                      text: 'LogOut',
                      onPressed: () => showLogoutDialog(context),
                      backgroundColor: AppColors.redColor,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
