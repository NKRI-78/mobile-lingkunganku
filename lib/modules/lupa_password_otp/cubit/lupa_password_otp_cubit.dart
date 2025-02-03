import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/misc/snackbar.dart';
import 'package:mobile_lingkunganku/modules/lupa_password_otp/cubit/lupa_password_otp_state.dart';
import 'package:mobile_lingkunganku/repositories/auth_repository/auth_repository.dart';
import 'package:mobile_lingkunganku/router/builder.dart';

class LupaPasswordOtpCubit extends Cubit<LupaPasswordOtpState> {
  LupaPasswordOtpCubit() : super(LupaPasswordOtpState());

  AuthRepository repo = getIt<AuthRepository>();

  void init(String email) {
    emit(state.copyWith(email: email));
  }

  Future<void> submit(BuildContext context, String verificationCode) async {
    try {
      emit(state.copyWith(loading: true));
      await repo.forgotPasswordVerifyOTP(state.email, verificationCode);
      if (context.mounted) {
        ShowSnackbar.snackbar(
            context, "Berhasil Verifikasi OTP", '', AppColors.secondaryColor);
        LupaPasswordChangeRoute(email: state.email, otp: verificationCode)
            .push(context);
      }
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      ShowSnackbar.snackbar(context, e.toString(), '', AppColors.redColor);
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> forgotPasswordSendOTP(BuildContext context) async {
    try {
      emit(state.copyWith(loading: true));
      await repo.forgotPasswordSendOTP(state.email);
      debugPrint("Berhasil");
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      ShowSnackbar.snackbar(context, e.toString(), '', AppColors.redColor);
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  void copyState({required LupaPasswordOtpState newState}) {
    emit(newState);
  }
}
