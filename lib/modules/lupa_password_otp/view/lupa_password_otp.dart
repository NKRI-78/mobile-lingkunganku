import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/modules/lupa_password_otp/cubit/lupa_password_otp_cubit.dart';
import 'package:mobile_lingkunganku/modules/lupa_password_otp/cubit/lupa_password_otp_state.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../widgets/background/custom_background.dart';

class LupaPasswordOtpPage extends StatelessWidget {
  final String email;
  const LupaPasswordOtpPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    debugPrint("Email : $email");
    return BlocProvider<LupaPasswordOtpCubit>(
        create: (context) => LupaPasswordOtpCubit()..init(email),
        child: const LupaPasswordOtpView());
  }
}

class LupaPasswordOtpView extends StatelessWidget {
  const LupaPasswordOtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LupaPasswordOtpCubit, LupaPasswordOtpState>(
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
                        "Masukkan Kode OTP yang ada pada\nWhatsApp kamu, jangan kasih tahu\nsiapa-siapa ya!",
                        style: AppTextStyles.textStyle2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 50),
                    OtpTextField(
                      enabledBorderColor: AppColors.buttonColor1,
                      focusedBorderColor: AppColors.textColor1,
                      cursorColor: AppColors.textColor1,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      fieldWidth: 55,
                      fieldHeight: 70,
                      numberOfFields: 4,
                      textStyle: AppTextStyles.textStyle1,
                      showFieldAsBox: true,
                      onSubmit: (value) {
                        context
                            .read<LupaPasswordOtpCubit>()
                            .submit(context, value);
                      },
                    ),
                    SizedBox(height: 30),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Klik disini',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Intel',
                              fontWeight: FontWeight.bold,
                              color: AppColors.redColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('Anda sudah klik');
                                // trigger send otp
                                context
                                    .read<LupaPasswordOtpCubit>()
                                    .forgotPasswordSendOTP(context);
                              },
                          ),
                          TextSpan(
                            text: " apabila belum mendapatkan\nKode OTP",
                            style: AppTextStyles.textStyle2,
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   bottom: 30,
            //   left: 24,
            //   right: 24,
            //   child: CustomButton(
            //     horizontalPadding: 80,
            //     text: 'Reset Password',
            //     onPressed: () {
            //       print(state.otp);
            //       context
            //           .read<LupaPasswordOtpCubit>()
            //           .submit(context, state.otp);
            //     },
            //   ),
            // ),
          ],
        ),
      );
    });
  }
}
