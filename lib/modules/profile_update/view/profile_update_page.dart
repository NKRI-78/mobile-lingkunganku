import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/modules/profile_update/cubit/profile_update_cubit.dart';
import 'package:mobile_lingkunganku/modules/profile_update/widget/custom_textfield_name.dart';
import 'package:mobile_lingkunganku/modules/profile_update/widget/custom_textfield_phone.dart';
import 'package:mobile_lingkunganku/widgets/background/custom_background.dart';
import 'package:mobile_lingkunganku/widgets/button/custom_button.dart';
import 'package:mobile_lingkunganku/widgets/header/custom_header_container.dart';

class ProfileUpdatePage extends StatelessWidget {
  const ProfileUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileUpdateCubit>(
        create: (context) => ProfileUpdateCubit(),
        child: const ProfielUpdateView());
  }
}

class ProfielUpdateView extends StatelessWidget {
  const ProfielUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileUpdateCubit, ProfileUpdateState>(
      listener: (context, state) {
        if (state.successMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage),
              backgroundColor: AppColors.secondaryColor,
            ),
          );
          Navigator.pop(context);
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.redColor,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              CustomBackground(),
              Column(
                children: [
                  CustomHeaderContainer(
                    displayText: '',
                    isLoggedIn: true,
                    showText: false,
                    title: 'Edit Profile',
                    onBackPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextfieldName(),
                        CustomTextfieldPhone(),
                        SizedBox(height: 10),
                        CustomButton(
                          horizontalPadding: 140,
                          text: 'Save',
                          onPressed: () {
                            context.read<ProfileUpdateCubit>().updateProfile(
                                  context: context,
                                  fullname: context
                                      .read<ProfileUpdateCubit>()
                                      .state
                                      .fullname,
                                  phone: context
                                      .read<ProfileUpdateCubit>()
                                      .state
                                      .phone,
                                );
                          },
                        )
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
