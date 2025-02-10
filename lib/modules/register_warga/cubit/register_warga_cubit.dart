import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/snackbar.dart';
import '../../../repositories/auth_repository/auth_repository.dart';
import '../../../router/builder.dart';

part 'register_warga_state.dart';

class RegisterWargaCubit extends Cubit<RegisterWargaState> {
  RegisterWargaCubit() : super(RegisterWargaState());

  AuthRepository repo = getIt<AuthRepository>();

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
        isConfirmPasswordObscured: !state.isConfirmPasswordObscured));
  }

  void copyState({required RegisterWargaState newState}) {
    emit(newState);
  }

  bool submissionValidation(
    BuildContext context, {
    required String phone,
    required String email,
    required String password,
    required String passwordConfirm,
    required String referral,
  }) {
    debugPrint("Password $password Confirm Password $passwordConfirm");
    if (!email
        .contains(RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'))) {
      ShowSnackbar.snackbar(
          context, "Harap masukkan email yang tepat", '', AppColors.redColor);
      return false;
    } else if (phone.length < 10) {
      ShowSnackbar.snackbar(
          context, "No Hp Minimal 10 Angka", '', AppColors.redColor);
      return false;
    } else if (password.length < 8) {
      ShowSnackbar.snackbar(
          context, "Kata Sandi minimal 8 character", '', AppColors.redColor);
      return false;
    } else if (passwordConfirm.length < 8) {
      ShowSnackbar.snackbar(context,
          "Konfirmasi Kata Sandi minimal 8 character", '', AppColors.redColor);
      return false;
    } else if (passwordConfirm != password) {
      ShowSnackbar.snackbar(
          context, "Kata Sandi tidak cocok", '', AppColors.redColor);
      return false;
    } else if (referral.isEmpty) {
      ShowSnackbar.snackbar(
          context, "Harap masukkan kode referral", '', AppColors.redColor);
      return false;
    }
    return true;
  }

  Future<void> submit(BuildContext context) async {
    try {
      emit(state.copyWith(isLoading: true));

      debugPrint("Referral sebelum validasi: ${state.referral}");

      // Validasi input
      final bool isClear = submissionValidation(
        context,
        phone: state.phone,
        email: state.email,
        password: state.password,
        passwordConfirm: state.passwordConfirm,
        referral: state.referral,
      );

      // Jika validasi gagal, hentikan proses
      if (!isClear) {
        emit(state.copyWith(isLoading: false));
        return;
      }

      debugPrint("Referral setelah validasi: ${state.referral}");

      await repo.registerMember(
        name: state.name,
        email: state.email,
        phone: state.phone,
        detailAddress: state.detailAddress,
        password: state.password,
        referral: state.referral,
      );

      // Navigasi ke halaman OTP jika berhasil
      if (context.mounted) {
        RegisterOtpRoute(email: state.email).push(context);
      }
    } catch (e) {
      if (!context.mounted) return;
      print(e);
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
      emit(state.copyWith(isLoading: false));
    }
  }
}
