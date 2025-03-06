import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocListener<AppBloc, AppState>(
      listener: (context, appState) {
        //
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final appState = getIt<AppBloc>().state;
          final bool isLoggedIn = appState.isAlreadyLogin;
          final role = state.profile?.roleApp ?? '';
          final avatarLink = state.profile?.profile?.avatarLink ?? '';

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
                          height: 80,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/icons/lingkunganku.png'),
                              fit: BoxFit.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.textColor1,
                          child: avatarLink.isNotEmpty && isLoggedIn
                              ? ClipOval(
                                  child: Image.network(
                                    avatarLink,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                      Icons.person,
                                      size: 60,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  size: 60,
                                  color: AppColors.whiteColor,
                                ),
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Container(
                                      color: Colors.black.withOpacity(0.1)),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
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
                                              size: 26,
                                              color: AppColors.whiteColor),
                                          title: Text("Profile",
                                              style: AppTextStyles
                                                  .textProfileBold),
                                          onTap: () {
                                            ProfileRoute().go(context);
                                          },
                                        ),
                                      ListTile(
                                        leading: Icon(Icons.settings_outlined,
                                            size: 26,
                                            color: AppColors.whiteColor),
                                        title: Text("Settings",
                                            style:
                                                AppTextStyles.textProfileBold),
                                        onTap: () {
                                          SettingsRoute().go(context);
                                        },
                                      ),
                                      if (isLoggedIn)
                                        if (role != "MEMBER" &&
                                            role != "SECRETARY" &&
                                            role != "TREASURER")
                                          ListTile(
                                            leading: Icon(
                                                Icons.description_outlined,
                                                size: 26,
                                                color: AppColors.whiteColor),
                                            title: Text("Data Warga",
                                                style: AppTextStyles
                                                    .textProfileBold),
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
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
