part of 'register_otp_cubit.dart';

class RegisterOtpState {
  final bool loading;
  final String otp;
  final String email;
  final String newEmail;

  RegisterOtpState({
    this.loading = false,
    this.otp = '',
    this.email = '',
    this.newEmail = '',
  });

  RegisterOtpState copyWith({
    bool? loading,
    String? otp,
    String? email,
    String? newEmail,
  }) {
    return RegisterOtpState(
      loading: loading ?? this.loading,
      otp: otp ?? this.otp,
      email: email ?? this.email,
      newEmail: newEmail ?? this.newEmail,
    );
  }
}
