import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/modules/lupa_password/cubit/lupa_password_state.dart';
import 'package:mobile_lingkunganku/router/builder.dart';

import '../../../misc/injections.dart';
import '../../../misc/snackbar.dart';
import '../../../repositories/auth_repository/auth_repository.dart';

class LupaPasswordCubit extends Cubit<LupaPasswordState> {
  LupaPasswordCubit() : super(LupaPasswordState());

  AuthRepository repo = getIt<AuthRepository>();

  Future<void> submit(BuildContext context) async {
    try {
      emit(state.copyWith(loading: true));
      await repo.forgotPasswordSendOTP(state.email);
      if (context.mounted) {
        ShowSnackbar.snackbar(
            context, "Silahkan cek email", '', AppColors.secondaryColor);
        LupaPasswordOtpRoute(email: state.email).push(context);
      }
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      ShowSnackbar.snackbar(
          context, e.toString(), '', AppColors.secondaryColor);
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  void copyState({required LupaPasswordState newState}) {
    emit(newState);
  }
}
