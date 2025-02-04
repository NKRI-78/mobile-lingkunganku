import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/modules/app/bloc/app_bloc.dart';
import 'package:mobile_lingkunganku/modules/home/widget/show_dialog_logout.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../router/builder.dart';
import '../../../widgets/button/custom_button.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = getIt<AppBloc>().state;
    final bool isLoggedIn = appState.isAlreadyLogin;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 50),
                children: <Widget>[
                  /// **Logo Aplikasi**
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/lingkunganku.png'),
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

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
                  SizedBox(height: 40),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
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
                                // ProfileRoute().go(context);
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
                            ListTile(
                              leading: Icon(Icons.description_outlined,
                                  color: AppColors.whiteColor),
                              title: Text("Kepengurusan",
                                  style: AppTextStyles.buttonText1),
                              onTap: () {
                                // ManagementRoute().go(context);
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: CustomButton(
                text: isLoggedIn ? 'Logout' : 'Close App',
                onPressed: () {
                  if (isLoggedIn) {
                    showLogoutDialog(context);
                  } else {
                    GoRouter.of(context).pop();
                  }
                },
                backgroundColor: AppColors.redColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
