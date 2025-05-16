import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../widgets/background/custom_background.dart';
import '../cubit/lupa_password_otp_cubit.dart';

class LupaPasswordOtpPage extends StatelessWidget {
  const LupaPasswordOtpPage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
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
      final minutes = (state.timeRemaining / 60).floor();
      final seconds = state.timeRemaining % 60;
      final timeRemaining = '$minutes:${seconds.toString().padLeft(2, '0')}';

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
                size: 24,
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Kami telah mengirimkan kode OTP ke\n${state.email}",
                        style: AppTextStyles.textStyle2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Silakan masukkan kode OTP untuk melanjutkan.",
                        style: AppTextStyles.textStyle2.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Pinput(
                        androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                        length: 4,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 70,
                          textStyle: AppTextStyles.textStyle1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.buttonColor1),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 60,
                          height: 70,
                          textStyle: AppTextStyles.textStyle1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.textColor1),
                          ),
                        ),
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 2,
                              height: 30,
                              color: AppColors.textColor1,
                            ),
                          ],
                        ),
                        keyboardType: TextInputType.number,
                        onCompleted: (value) {
                          context
                              .read<LupaPasswordOtpCubit>()
                              .submit(context, value);
                        },
                        onChanged: (value) {
                          debugPrint("OTP: $value");
                        },
                      ),
                      SizedBox(height: 30),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: state.timerFinished
                                  ? 'Klik disini'
                                  : timeRemaining,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Intel',
                                fontWeight: FontWeight.bold,
                                color: state.timerFinished
                                    ? AppColors.redColor
                                    : AppColors.secondaryColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  if (state.timerFinished) {
                                    context
                                        .read<LupaPasswordOtpCubit>()
                                        .forgotPasswordSendOTP(context);
                                  }
                                },
                            ),
                            TextSpan(
                              text: " apabila belum mendapatkan\nKode OTP",
                              style: AppTextStyles.textStyle2.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
