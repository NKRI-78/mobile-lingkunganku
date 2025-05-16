import 'dart:io';

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

  void updateGender(String newGender) {
    emit(state.copyWith(gender: newGender));
  }

  void toggleTermsAcceptance(bool value) {
    emit(state.copyWith(isTermsAccepted: value));
  }

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
    required String name,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirm,
    required String referral,
  }) {
    debugPrint("Password $password Confirm Password $passwordConfirm");
    if (name.isEmpty) {
      ShowSnackbar.snackbar(
          context, "Harap masukkan nama", '', AppColors.redColor);
      return false;
    } else if (!email
        .contains(RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'))) {
      ShowSnackbar.snackbar(
          context, "Harap masukkan email yang tepat", '', AppColors.redColor);
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
    } else if (!state.isTermsAccepted) {
      ShowSnackbar.snackbar(context,
          "Anda harus menyetujui syarat dan ketentuan", '', AppColors.redColor);
      return false;
    }
    return true;
  }

  Future<void> submit(BuildContext context) async {
    try {
      emit(state.copyWith(isLoading: true));

      debugPrint("Referral sebelum validasi: ${state.referral}");
      if (state.fileImage == null) {
        ShowSnackbar.snackbar(
            context, "Harap masukkan foto", '', AppColors.redColor);
        emit(state.copyWith(isLoading: false));
        return;
      }

      // Validasi input
      final bool isClear = submissionValidation(
        context,
        name: state.name,
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

      final linkImage =
          await repo.postMedia(folder: "images", media: state.fileImage!);
      final remaplink =
          linkImage.map((e) => {'url': e, 'type': "image"}).toList();

      await repo.registerMember(
        name: state.name,
        email: state.email,
        phone: state.phone,
        detailAddress: state.detailAddress,
        password: state.password,
        referral: state.referral,
        avatarLink: remaplink[0]['url']['url'],
        gender: state.gender.isEmpty ? '-' : state.gender,
      );

      // Jika berhasil, langsung pindah halaman
      if (context.mounted) {
        RegisterOtpRoute(
          email: state.email,
          isLogin: true,
        ).push(context);
        ShowSnackbar.snackbar(
          context,
          "Kode OTP telah dikirim, silakan cek email Anda.",
          '',
          AppColors.secondaryColor,
        );
      }
    } catch (e) {
      if (!context.mounted) return;
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
