import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/misc/snackbar.dart';
import 'package:mobile_lingkunganku/modules/profile/cubit/profile_cubit.dart';
import 'package:mobile_lingkunganku/repositories/profile_repository/profile_repository.dart';

part 'profile_update_state.dart';

class ProfileUpdateCubit extends Cubit<ProfileUpdateState> {
  ProfileUpdateCubit() : super(ProfileUpdateState());

  final ProfileRepository profile = getIt<ProfileRepository>();

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

  // Fungsi untuk update profile
  Future<void> updateProfile({
    required BuildContext context,
    String linkAvatar = '',
    String fullname = '',
    String phone = '',
  }) async {
    try {
      // Check validation before proceeding
      final isValid =
          submissionValidation(context, fullname: fullname, phone: phone);
      if (!isValid) {
        return;
      }

      // Set state to loading
      emit(state.copyWith(isLoading: true));

      // Update profile using repository
      await profile.updateProfile(
        linkAvatar: linkAvatar,
        fullname: fullname,
        phone: phone,
      );

      // Update state to success
      emit(state.copyWith(
        isLoading: false,
        successMessage: 'Profile berhasil diperbarui',
      ));
      getIt<ProfileCubit>().getProfile();
    } catch (error) {
      // Update state to error if something goes wrong
      emit(state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      ));
    }
  }
}
