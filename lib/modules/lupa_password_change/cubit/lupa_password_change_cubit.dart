import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'lupa_password_change_state.dart';

class LupaPasswordChangeCubit extends Cubit<LupaPasswordChangeState> {
  LupaPasswordChangeCubit() : super(LupaPasswordChangeState());

  void togglePasswordVisibility() {
    emit(LupaPasswordChangeState(
      isPasswordObscured: !state.isPasswordObscured,
      isConfirmPasswordObscured: state.isConfirmPasswordObscured,
    ));
  }

  void toggleConfirmPasswordVisibility() {
    emit(LupaPasswordChangeState(
      isPasswordObscured: state.isPasswordObscured,
      isConfirmPasswordObscured: !state.isConfirmPasswordObscured,
    ));
  }

  void copyState(LupaPasswordChangeState newState) {
    emit(newState);
  }
}
