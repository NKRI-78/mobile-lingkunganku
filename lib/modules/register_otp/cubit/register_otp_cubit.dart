import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../repositories/auth_repository/auth_repository.dart';
import '../../../router/builder.dart';
import '../../app/bloc/app_bloc.dart';

part 'register_otp_state.dart';

class RegisterOtpCubit extends Cubit<RegisterOtpState> {
  RegisterOtpCubit() : super(RegisterOtpState());

  AuthRepository repo = getIt<AuthRepository>();

  void init(String email) async {
    emit(state.copyWith(email: email));
    await repo.resendOtp(state.email);
  }

  Future<void> submit(String verificationCode, BuildContext context) async {
    try {
      emit(state.copyWith(loading: true));
      final loggedIn = await repo.verifyOtp(
          state.email, verificationCode, VerifyEmailType.verified);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.textColor1,
            content: Text(
              'Verify berhasil, selamat datang di Lingkunganku.',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        getIt<AppBloc>().add(
          SetUserData(user: loggedIn!.user, token: loggedIn.token),
        );

        HomeRoute().go(context);
      }
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.redColor,
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    try {
      emit(state.copyWith(loading: true));
      await repo.resendOtp(state.email);
      debugPrint("Berhasil");
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.redColor,
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  // Future<void> chageEmailOtp(BuildContext context) async {
  //   try {
  //     emit(state.copyWith(loading: true));
  //     await repo.chageEmailOtp(state.email, state.newEmail);
  //     debugPrint("Berhasil");
  //     emit(state.copyWith(email: state.newEmail));
  //   } catch (e) {
  //     if (!context.mounted) {
  //       return;
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: AppColors.redColor,
  //         content: Text(
  //           e.toString(),
  //           style: const TextStyle(color: Colors.white),
  //         ),
  //       ),
  //     );
  //   } finally {
  //     emit(state.copyWith(loading: false));
  //   }
  // }

  void copyState({required RegisterOtpState newState}) {
    emit(newState);
  }
}
