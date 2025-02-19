import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../widgets/background/custom_background.dart';
import '../../../widgets/button/custom_button.dart';
import '../cubit/lupa_password_change_cubit.dart';

part '../widget/custom_textfield_password.dart';

class LupaPasswordChangePage extends StatelessWidget {
  const LupaPasswordChangePage(
      {super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  Widget build(BuildContext context) {
    debugPrint("otp : $otp");
    return BlocProvider<LupaPasswordChangeCubit>(
      create: (context) => LupaPasswordChangeCubit(email: email, otp: otp),
      child: LupaPasswordChangeView(),
    );
  }
}

class LupaPasswordChangeView extends StatelessWidget {
  const LupaPasswordChangeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          toolbarHeight: 80,
          title: Text(
            'Reset Password',
            style: AppTextStyles.textStyle1,
          ),
          centerTitle: true,
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white.withOpacity(0.3), Colors.transparent],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          CustomBackground(),
          Padding(
            padding: EdgeInsets.only(top: 100, left: 24, right: 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Masukkan Password baru kamu, kali ini\njangan sampai lupa yaa!",
                      style: AppTextStyles.textStyle2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomTextFieldPassword(),
                  // SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 24,
            right: 24,
            child: SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Konfirmasi',
                onPressed: () {
                  context.read<LupaPasswordChangeCubit>().submit(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
