import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  void togglePasswordVisibility() {
    emit(LoginState(
      isPasswordObscured: !state.isPasswordObscured,
    ));
  }

  void copyState(LoginState newState) {
    emit(newState);
  }
}
