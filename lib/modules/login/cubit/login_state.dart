part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool loading;
  final bool isPasswordObscured;

  const LoginState({
    this.email = '',
    this.password = '',
    this.loading = false,
    this.isPasswordObscured = true,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        loading,
        isPasswordObscured,
      ];

  LoginState copyWith({
    String? email,
    String? password,
    bool? loading,
    bool? isPasswordObscured,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      loading: loading ?? this.loading,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
    );
  }
}
