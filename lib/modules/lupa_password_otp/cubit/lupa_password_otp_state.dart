part of 'lupa_password_otp_cubit.dart';

class LupaPasswordOtpState {
  final String email;
  final bool loading;
  final String otp;
  final int timeRemaining;
  final bool timerFinished;

  LupaPasswordOtpState({
    this.email = "",
    this.loading = false,
    this.otp = "",
    this.timeRemaining = 120,
    this.timerFinished = false,
  });

  LupaPasswordOtpState copyWith({
    String? email,
    bool? loading,
    String? otp,
    int? timeRemaining,
    bool? timerFinished,
  }) {
    return LupaPasswordOtpState(
      email: email ?? this.email,
      loading: loading ?? this.loading,
      otp: otp ?? this.otp,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      timerFinished: timerFinished ?? this.timerFinished,
    );
  }
}
