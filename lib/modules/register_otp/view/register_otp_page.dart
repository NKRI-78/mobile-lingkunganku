import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../widgets/background/custom_background.dart';
import '../cubit/register_otp_cubit.dart';

class RegisterOtpPage extends StatelessWidget {
  const RegisterOtpPage(
      {super.key, required this.email, required this.isLogin});

  final String email;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterOtpCubit>(
      create: (context) => RegisterOtpCubit(isLogin)..init(email),
      child: RegisterOtpView(),
    );
  }
}

class RegisterOtpView extends StatelessWidget {
  const RegisterOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterOtpCubit, RegisterOtpState>(
      builder: (context, state) {
        // Hitung detik yang tersisa
        final minutes = (state.timeRemaining / 60).floor();
        final seconds = state.timeRemaining % 60;
        final timeRemaining = '$minutes:${seconds.toString().padLeft(2, '0')}';

        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AppBar(
                toolbarHeight: 80,
                title: Text(
                  'Kode OTP',
                  style: AppTextStyles.textStyle1,
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.transparent
                      ],
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
                            "Kami telah mengirimkan Kode OTP\nke ${state.email} yang di gunakan pada saat Registrasi.",
                            style: AppTextStyles.textStyle2.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Masukkan Kode OTP pada kolom yang tersedia",
                            style: AppTextStyles.textStyle2.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Pinput(
                            androidSmsAutofillMethod:
                                AndroidSmsAutofillMethod.none,
                            length: 4,
                            defaultPinTheme: PinTheme(
                              width: 60,
                              height: 70,
                              textStyle: AppTextStyles.textStyle1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: AppColors.buttonColor1),
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
                                  .read<RegisterOtpCubit>()
                                  .submit(value, context);
                            },
                            onChanged: (value) {
                              print("OTP: $value");
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
                                            .read<RegisterOtpCubit>()
                                            .resendOtp(context);
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
          ),
        );
      },
    );
  }
}
