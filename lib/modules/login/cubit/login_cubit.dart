import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/snackbar.dart';
import '../../../repositories/auth_repository/auth_repository.dart';
import '../../../router/builder.dart';
import '../../app/bloc/app_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  AuthRepository repo = getIt<AuthRepository>();

  void copyState({required LoginState newState}) {
    emit(newState);
  }

  Future<void> submit(BuildContext context) async {
    if (!_validateInputs(context)) return;

    try {
      emit(state.copyWith(loading: true));

      final loggedIn =
          await repo.login(email: state.email, password: state.password);

      if (context.mounted) {
        getIt<AppBloc>()
            .add(SetUserData(user: loggedIn.user, token: loggedIn.token));
        HomeRoute().go(context);
        ShowSnackbar.snackbar(context, 'Selamat datang di Lingkunganku', '',
            AppColors.secondaryColor);
      }
    } on EmailNotActivatedFailure {
      if (!context.mounted) {
        return;
      }
      RegisterOtpRoute(
        email: state.email,
        isLogin: true,
      ).push(context);
    } catch (e) {
      if (!context.mounted) return;

      String errorMessage;

      if (e is EmailNotFoundFailure) {
        errorMessage =
            "Email ini tidak terdaftar. Silakan coba lagi atau daftar akun baru.";
      } else if (e.toString().toLowerCase().contains("user not found")) {
        errorMessage =
            "Email ini tidak terdaftar. Pastikan email yang Anda masukkan benar.";
      } else {
        errorMessage = e.toString();
      }

      ShowSnackbar.snackbar(
        context,
        errorMessage,
        '',
        AppColors.redColor,
      );
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  /// 🔹 Validasi email dan password sebelum login
  bool _validateInputs(BuildContext context) {
    if (state.email.isEmpty) {
      ShowSnackbar.snackbar(
          context, "Email tidak boleh kosong", '', AppColors.redColor);
      return false;
    }
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(state.email)) {
      ShowSnackbar.snackbar(
          context, "Format email tidak valid", '', AppColors.redColor);
      return false;
    }
    if (state.password.isEmpty) {
      ShowSnackbar.snackbar(
          context, "Password tidak boleh kosong", '', AppColors.redColor);
      return false;
    }
    if (state.password.length < 8) {
      ShowSnackbar.snackbar(
          context, "Password harus minimal 8 karakter", '', AppColors.redColor);
      return false;
    }
    return true;
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }
}
