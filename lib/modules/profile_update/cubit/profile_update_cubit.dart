import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/snackbar.dart';
import '../../../repositories/auth_repository/auth_repository.dart';
import '../../../repositories/profile_repository/models/profile_model.dart';
import '../../profile/cubit/profile_cubit.dart';
import '../../../repositories/profile_repository/profile_repository.dart';

part 'profile_update_state.dart';

class ProfileUpdateCubit extends Cubit<ProfileUpdateState> {
  ProfileUpdateCubit() : super(ProfileUpdateState()) {
    _fetchProfile();
  }

  final ProfileRepository profile = getIt<ProfileRepository>();
  AuthRepository repo = getIt<AuthRepository>();

  Future<void> _fetchProfile() async {
    try {
      final userProfile = await profile.getProfile();
      emit(state.copyWith(profile: userProfile));
    } catch (e) {
      emit(state.copyWith(errorMessage: "Gagal memuat profil"));
    }
  }

  void copyState({required ProfileUpdateState newState}) {
    emit(newState);
  }

  // Fungsi untuk validasi profile update
  bool submissionValidation(
    BuildContext context, {
    required String fullname,
    required String phone,
  }) {
    if (fullname.isEmpty) {
      ShowSnackbar.snackbar(
          context, "Nama tidak boleh kosong", '', AppColors.redColor);
      return false;
    } else if (phone.isEmpty) {
      ShowSnackbar.snackbar(
          context, "Nomor telepon tidak boleh kosong", '', AppColors.redColor);
      return false;
    } else if (phone.length < 10) {
      ShowSnackbar.snackbar(context, "Nomor telepon harus minimal 10 digit", '',
          AppColors.redColor);
      return false;
    }

    return true;
  }

  // Fungsi untuk update profile (Foto tidak wajib)
  Future<void> updateProfile({
    required BuildContext context,
    required String fullname,
    required String phone,
    File? avatarFile,
  }) async {
    try {
      final isValid =
          submissionValidation(context, fullname: fullname, phone: phone);
      if (!isValid) {
        return;
      }

      // Ambil foto lama jika user tidak mengupload yang baru
      String avatarUrl = state.profile?.profile?.avatarLink ?? '';

      if (avatarFile != null) {
        // Upload foto baru jika diberikan
        final linkImage =
            await repo.postMedia(folder: "images", media: avatarFile);
        final remaplink =
            linkImage.map((e) => {'url': e, 'type': "image"}).toList();

        avatarUrl = remaplink[0]['url']['url'];
      }

      // Set state to loading
      emit(state.copyWith(isLoading: true));

      // Update profile menggunakan avatar lama atau yang baru
      await profile.updateProfile(
        fullname: fullname,
        phone: phone,
        avatarLink: avatarUrl,
      );

      // Update state ke sukses
      emit(state.copyWith(
        isLoading: false,
        successMessage: 'Profile berhasil diperbarui',
      ));

      getIt<ProfileCubit>().getProfile();
    } catch (error) {
      // Update state ke error jika ada masalah
      emit(state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      ));
    }
  }
}
