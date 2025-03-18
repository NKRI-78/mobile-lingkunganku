import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/snackbar.dart';
import '../../../repositories/sos_repository/sos_repository.dart';
import '../../../repositories/profile_repository/profile_repository.dart';

import '../../../repositories/profile_repository/models/profile_model.dart';

part 'sos_state.dart';

class SosCubit extends Cubit<SosState> {
  SosCubit() : super(const SosState());

  ProfileRepository repoProfile = getIt<ProfileRepository>();
  SosRepository repo = getIt<SosRepository>();

  void copyState({required SosState newState}) {
    emit(newState);
  }

  Future<void> sendSos(
      String title, String description, BuildContext context) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      debugPrint("Sos ${position.latitude}");
      debugPrint("Sos ${position.longitude}");
      await repo.sendSos(
        longitude: position.longitude.toString(),
        latitude: position.latitude.toString(),
        title: title,
        message:
            "$description ${place.thoroughfare} ${place.subThoroughfare} ${place.locality}, ${place.postalCode}",
      );
      Future.delayed(Duration.zero, () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context, rootNavigator: true).pop();
        ShowSnackbar.snackbar(
            context, "Berhasil mengirim SOS", "", AppColors.secondaryColor);
      });
    } on Exception catch (e) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context, rootNavigator: true).pop();
        ShowSnackbar.snackbar(context, e.toString(), "", AppColors.redColor);
      });
    }
  }

  Future<void> getProfile() async {
    try {
      emit(state.copyWith(isLoading: true));

      final profile = await repoProfile.getProfile();

      emit(state.copyWith(
        profile: profile,
      ));
    } catch (e) {
      emit(state.copyWith(errorMessage: "Gagal memuat profil: $e"));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
