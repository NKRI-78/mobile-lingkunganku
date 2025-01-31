import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/repositories/auth_repository/auth_repository.dart';
import 'package:mobile_lingkunganku/router/builder.dart';

import '../../../misc/snackbar.dart';

part 'register_ketua_state.dart';

class RegisterKetuaCubit extends Cubit<RegisterKetuaState> {
  RegisterKetuaCubit() : super(const RegisterKetuaState());

  AuthRepository repo = getIt<AuthRepository>();

  static GoogleMapController? googleMapCheckIn;

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
        isConfirmPasswordObscured: !state.isConfirmPasswordObscured));
  }

  bool submissionValidation(
    BuildContext context, {
    required String phone,
    required String email,
    required String password,
    required String passwordConfirm,
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
    }

    return true;
  }

  void copyState({required RegisterKetuaState newState}) {
    emit(newState);
  }

  Future<void> submit(BuildContext context) async {
    try {
      emit(state.copyWith(isLoading: true));
      final bool isClear = submissionValidation(
        context,
        phone: state.phone,
        email: state.email,
        password: state.password,
        passwordConfirm: state.passwordConfirm,
      );
      if (isClear) {
        await repo.registerChief(
          name: state.name,
          email: state.email,
          phone: state.phone,
          neighborhoodName: state.neighborhoodName,
          detailAddress: state.currentAddress,
          password: state.password,
          latitude: state.latitude.toString(),
          longitude: state.longitude.toString(),
        );
        if (context.mounted) {
          RegisterOtpRoute(email: state.email).push(context);
        }
      }
    } catch (e) {
      if (!context.mounted) {
        return;
      }
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

  Future<void> setAreaCurrent(GoogleMapController mapController) async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    emit(state.copyWith(
        latitude: position.latitude,
        longitude: position.longitude,
        currentAddress:
            "${place.thoroughfare} ${place.subThoroughfare} \n${place.locality}, ${place.postalCode}"));

    mapController.moveCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
    mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(state.latitude, state.longitude),
      zoom: 15.0,
    )));
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
