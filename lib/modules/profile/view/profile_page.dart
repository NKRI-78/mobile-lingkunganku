import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/modules/profile/cubit/profile_cubit.dart';
import 'package:mobile_lingkunganku/modules/profile/widget/family_member_section.dart';
import 'package:mobile_lingkunganku/modules/profile/widget/referral_code_chief.dart';
import 'package:mobile_lingkunganku/modules/profile/widget/referral_code_family.dart';
import 'package:mobile_lingkunganku/widgets/button/custom_button.dart';

import '../../../widgets/background/custom_background.dart';
import '../../../widgets/header/custom_header_container.dart';
import '../widget/profile_info_section.dart';
import '../widget/transfer_management_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileCubit>()..getProfile(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              const CustomBackground(),
              Column(
                children: [
                  CustomHeaderContainer(
                    isLoggedIn: true,
                    displayText: '',
                    showText: false,
                    title: 'Profile',
                    onBackPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        spacing: 20,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileInfoSection(),
                          TransferManagementSection(),
                          FamilyMemberSection(),
                          ReferralCodeChief(),
                          ReferralCodeFamily(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                text: 'Copy Download Link',
                                onPressed: () {
                                  // LINK APPS / LINK REFERRAL
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
