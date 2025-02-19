import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../widgets/background/custom_background.dart';
import '../../../widgets/button/custom_button.dart';
import '../cubit/lupa_password_cubit.dart';
import '../cubit/lupa_password_state.dart';

part '../widget/_field_email.dart';

class LupaPasswordPage extends StatelessWidget {
  const LupaPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LupaPasswordCubit>(
        create: (context) => LupaPasswordCubit(),
        child: const LupaPasswordView());
  }
}

class LupaPasswordView extends StatelessWidget {
  const LupaPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LupaPasswordCubit, LupaPasswordState>(
        builder: (context, state) {
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
              padding: EdgeInsets.only(top: 100, left: 32, right: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Masukan alamat email anda untuk\nmendapatkan kode OTP, untuk\nmereset Password",
                      style: AppTextStyles.textStyle2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  _FieldEmail(),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Kirim',
                      onPressed: () {
                        context.read<LupaPasswordCubit>().submit(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
