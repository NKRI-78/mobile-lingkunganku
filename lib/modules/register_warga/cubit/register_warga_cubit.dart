import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_lingkunganku/widgets/map/custom_select_location.dart';

part 'register_warga_state.dart';

class RegisterWargaCubit extends Cubit<RegisterWargaState> {
  RegisterWargaCubit() : super(RegisterWargaState());

  void togglePasswordVisibility() {
    emit(RegisterWargaState(
      isPasswordObscured: !state.isPasswordObscured,
      isConfirmPasswordObscured: state.isConfirmPasswordObscured,
    ));
  }

  void toggleConfirmPasswordVisibility() {
    emit(RegisterWargaState(
      isPasswordObscured: state.isPasswordObscured,
      isConfirmPasswordObscured: !state.isConfirmPasswordObscured,
    ));
  }

  void copyState(RegisterWargaState newState) {
    emit(newState);
  }
}
