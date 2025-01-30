part of 'lupa_password_change_cubit.dart';

class LupaPasswordChangeState extends Equatable {
  final bool isPasswordObscured;
  final bool isConfirmPasswordObscured;

  const LupaPasswordChangeState({
    this.isConfirmPasswordObscured = true,
    this.isPasswordObscured = true,
  });

  @override
  List<Object?> get props => [
        isPasswordObscured,
        isConfirmPasswordObscured,
      ];

  LupaPasswordChangeState copyWith({
    bool? isPasswordObscured,
    bool? isConfirmPasswordObscured,
  }) {
    return LupaPasswordChangeState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      isConfirmPasswordObscured:
          isConfirmPasswordObscured ?? this.isConfirmPasswordObscured,
    );
  }
}
