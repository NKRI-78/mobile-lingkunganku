import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../app/bloc/app_bloc.dart';
import '../../../router/builder.dart';

import '../../../misc/injections.dart';
import '../../../repositories/auth_repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  AuthRepository repo = getIt<AuthRepository>();

  void copyState({required LoginState newState}) {
    emit(newState);
  }

  Future<void> submit(BuildContext context) async {
    try {
      emit(state.copyWith(loading: true));
      final loggedIn =
          await repo.login(email: state.email, password: state.password);
      if (context.mounted) {
        getIt<AppBloc>()
            .add(SetUserData(user: loggedIn.user, token: loggedIn.token));
        HomeRoute().go(context);
      }
    } on EmailNotActivatedFailure {
      if (!context.mounted) {
        return;
      }
      RegisterOtpRoute(email: state.email).push(context);
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.secondaryColor,
          content: Text(e.toString(), style: AppTextStyles.textDialog),
        ),
      );
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  void togglePasswordVisibility() {
    emit(LoginState(
      isPasswordObscured: !state.isPasswordObscured,
    ));
  }
}
