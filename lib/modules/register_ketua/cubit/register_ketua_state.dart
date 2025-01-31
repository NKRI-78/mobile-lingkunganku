part of 'register_ketua_cubit.dart';

class RegisterKetuaState extends Equatable {
  final bool isLoading;
  final bool isPasswordObscured;
  final bool isConfirmPasswordObscured;
  final double latitude;
  final double longitude;
  final String currentAddress;
  final String name;
  final String email;
  final String phone;
  final String detailAddress;
  final String neighborhoodName;
  final String password;
  final String passwordConfirm;

  const RegisterKetuaState({
    this.isLoading = false,
    this.isPasswordObscured = true,
    this.isConfirmPasswordObscured = true,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.currentAddress = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.detailAddress = '',
    this.neighborhoodName = '',
    this.password = '',
    this.passwordConfirm = '',
  });

  RegisterKetuaState copyWith({
    bool? isLoading,
    bool? isPasswordObscured,
    bool? isConfirmPasswordObscured,
    double? latitude,
    double? longitude,
    String? currentAddress,
    String? name,
    String? email,
    String? phone,
    String? detailAddress,
    String? neighborhoodName,
    String? password,
    String? passwordConfirm,
  }) {
    return RegisterKetuaState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      isConfirmPasswordObscured:
          isConfirmPasswordObscured ?? this.isConfirmPasswordObscured,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      currentAddress: currentAddress ?? this.currentAddress,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      detailAddress: detailAddress ?? this.detailAddress,
      neighborhoodName: neighborhoodName ?? this.neighborhoodName,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isPasswordObscured,
        isConfirmPasswordObscured,
        latitude,
        longitude,
        currentAddress,
        name,
        email,
        phone,
        detailAddress,
        neighborhoodName,
        password,
        passwordConfirm,
      ];
}
