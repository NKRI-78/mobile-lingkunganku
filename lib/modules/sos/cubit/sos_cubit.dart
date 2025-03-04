import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/misc/snackbar.dart';
import 'package:mobile_lingkunganku/repositories/sos_repository/sos_repository.dart';
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
      debugPrint("Sos ${position.latitude}");
      debugPrint("Sos ${position.longitude}");
      await repo.sendSos(
        longitude: position.longitude.toString(),
        latitude: position.latitude.toString(),
        title: title,
        message: description,
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
