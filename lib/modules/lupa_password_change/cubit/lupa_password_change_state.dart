part of 'lupa_password_change_cubit.dart';

class LupaPasswordChangeState extends Equatable {
  final bool loading;
  final String password;
  final String passwordConfirm;
  final bool isPasswordObscured;
  final bool isConfirmPasswordObscured;

  const LupaPasswordChangeState({
    this.loading = false,
    this.password = '',
    this.passwordConfirm = '',
    this.isConfirmPasswordObscured = true,
    this.isPasswordObscured = true,
  });

  @override
  List<Object?> get props => [
        loading,
        password,
        passwordConfirm,
        isPasswordObscured,
        isConfirmPasswordObscured,
      ];

  LupaPasswordChangeState copyWith({
    bool? loading,
    String? password,
    String? passwordConfirm,
    bool? isPasswordObscured,
    bool? isConfirmPasswordObscured,
  }) {
    return LupaPasswordChangeState(
      loading: loading ?? this.loading,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      isConfirmPasswordObscured:
          isConfirmPasswordObscured ?? this.isConfirmPasswordObscured,
    );
  }
}
