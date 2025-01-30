part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isPasswordObscured;

  const LoginState({
    this.isPasswordObscured = true,
  });

  @override
  List<Object?> get props => [
        isPasswordObscured,
      ];

  LoginState copyWith({
    bool? isPasswordObscured,
  }) {
    return LoginState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
    );
  }
}
