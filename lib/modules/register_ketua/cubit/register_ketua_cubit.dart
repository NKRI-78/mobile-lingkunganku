import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/location.dart';
import '../../../misc/snackbar.dart';
import '../../../repositories/auth_repository/auth_repository.dart';
import '../../../router/builder.dart';

part 'register_ketua_state.dart';

class RegisterKetuaCubit extends Cubit<RegisterKetuaState> {
  RegisterKetuaCubit() : super(const RegisterKetuaState());

  AuthRepository repo = getIt<AuthRepository>();

  static GoogleMapController? googleMapCheckIn;

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

  bool submissionValidation(
    BuildContext context, {
    required String name,
    required String phone,
    required String phoneSecurity,
    required String email,
    required String password,
    required String passwordConfirm,
    required String neighborhoodName,
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
    } else if (neighborhoodName.isEmpty) {
      ShowSnackbar.snackbar(
          context, "Harap masukkan nama lingkungan", '', AppColors.redColor);
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
    } else if (!state.isTermsAccepted) {
      ShowSnackbar.snackbar(context,
          "Anda harus menyetujui syarat dan ketentuan", '', AppColors.redColor);
      return false;
    }

    return true;
  }

  void copyState({required RegisterKetuaState newState}) {
    emit(newState);
  }

  Future<void> submit(BuildContext context) async {
    try {
      emit(state.copyWith(isLoading: true));

      if (state.fileImage == null) {
        ShowSnackbar.snackbar(
            context, "Harap masukkan foto", '', AppColors.redColor);
        emit(state.copyWith(isLoading: false)); // Reset isLoading
        return;
      }

      final bool isClear = submissionValidation(
        context,
        neighborhoodName: state.neighborhoodName,
        name: state.name,
        phone: state.phone,
        phoneSecurity: state.phoneSecurity,
        email: state.email,
        password: state.password,
        passwordConfirm: state.passwordConfirm,
      );

      if (!isClear) {
        emit(state.copyWith(
            isLoading: false)); // Tambahkan ini jika validasi gagal
        return;
      }

      final linkImage =
          await repo.postMedia(folder: "images", media: state.fileImage!);
      final remaplink =
          linkImage.map((e) => {'url': e, 'type': "image"}).toList();

      await repo.registerChief(
        name: state.name,
        email: state.email,
        phone: state.phone,
        phoneSecurity: state.phoneSecurity,
        neighborhoodName: state.neighborhoodName,
        detailAddress: state.detailAddress,
        password: state.password,
        latitude: state.latitude.toString(),
        longitude: state.longitude.toString(),
        avatarLink: remaplink[0]['url']['url'],
        gender: state.gender.isEmpty ? '-' : state.gender,
      );

      if (context.mounted) {
        RegisterOtpRoute(email: state.email, isLogin: true).push(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.textColor1,
            content: Text(
              'Kode OTP telah dikirim, silakan cek email Anda.',
              style: TextStyle(color: Colors.white),
            ),
          ),
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

  Future<void> setAreaCurrent(
      GoogleMapController mapController, BuildContext context) async {
    try {
      // Memastikan izin lokasi sebelum melanjutkan
      await determinePosition(context);

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      emit(state.copyWith(
        latitude: position.latitude,
        longitude: position.longitude,
        currentAddress:
            "${place.thoroughfare} ${place.subThoroughfare} \n${place.locality}, ${place.postalCode}",
      ));

      mapController.moveCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
      );
      mapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(state.latitude, state.longitude),
          zoom: 15.0,
        ),
      ));
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> updateCurrentPositionCheckIn(
      BuildContext context, double lat, double lng) async {
    try {
      googleMapCheckIn?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 15.0)));
    } catch (e, stacktrace) {
      debugPrint(stacktrace.toString());
    }
  }
}
