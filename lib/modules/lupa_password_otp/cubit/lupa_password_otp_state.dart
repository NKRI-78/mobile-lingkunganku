class LupaPasswordOtpState {
  final String email;
  final bool loading;
  final String otp;

  LupaPasswordOtpState({
    this.email = "",
    this.loading = false,
    this.otp = "",
  });

  LupaPasswordOtpState copyWith({
    String? email,
    bool? loading,
    String? otp,
  }) {
    return LupaPasswordOtpState(
      email: email ?? this.email,
      loading: loading ?? this.loading,
      otp: otp ?? this.otp,
    );
  }
}
