part of 'register_warga_cubit.dart';

class RegisterWargaState extends Equatable {
  final bool isLoading;
  final bool isPasswordObscured;
  final bool isConfirmPasswordObscured;
  final String name;
  final String email;
  final String phone;
  final String detailAddress;
  final String password;
  final String passwordConfirm;
  final String referral;
  final File? fileImage;
  final String gender;
  final bool isTermsAccepted;

  const RegisterWargaState({
    this.isLoading = false,
    this.isPasswordObscured = true,
    this.isConfirmPasswordObscured = true,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.detailAddress = '',
    this.password = '',
    this.passwordConfirm = '',
    this.referral = '',
    this.fileImage,
    this.gender = '',
    this.isTermsAccepted = false,
  });

  @override
  List<Object?> get props => [
        isLoading,
        isPasswordObscured,
        isConfirmPasswordObscured,
        name,
        email,
        phone,
        detailAddress,
        password,
        passwordConfirm,
        referral,
        fileImage,
        gender,
        isTermsAccepted,
      ];

  RegisterWargaState copyWith({
    bool? isLoading,
    bool? isPasswordObscured,
    bool? isConfirmPasswordObscured,
    String? name,
    String? email,
    String? phone,
    String? detailAddress,
    String? password,
    String? passwordConfirm,
    String? referral,
    ValueGetter<File?>? fileImage,
    String? gender,
    bool? isTermsAccepted,
  }) {
    return RegisterWargaState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      isConfirmPasswordObscured:
          isConfirmPasswordObscured ?? this.isConfirmPasswordObscured,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      detailAddress: detailAddress ?? this.detailAddress,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      referral: referral ?? this.referral,
      fileImage: fileImage != null ? fileImage() : this.fileImage,
      gender: gender ?? this.gender,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
    );
  }
}
