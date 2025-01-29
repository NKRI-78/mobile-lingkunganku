part of 'register_ketua_cubit.dart';

class RegisterKetuaState extends Equatable {
  final String? name;
  final String? registerAddress;
  final String? province;
  final String? city;
  final String? subDistrict;
  final String? postalCode;
  final String? district;
  final LatLng? registerLocation;
  final SelectedAdministration? selectedAdministration;
  final bool loading;
  final double latitude;
  final double longitude;
  final String currentAddress;
  final File? fileImage;

  const RegisterKetuaState({
    this.name,
    this.registerLocation,
    this.district,
    this.registerAddress,
    this.province,
    this.city,
    this.subDistrict,
    this.postalCode,
    this.selectedAdministration,
    this.loading = false, // Default loading is false
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.currentAddress = "",
    this.fileImage,
  });

  @override
  List<Object?> get props => [
        name,
        registerLocation,
        district,
        registerAddress,
        province,
        city,
        subDistrict,
        postalCode,
        selectedAdministration,
        loading,
        latitude,
        longitude,
        currentAddress,
        fileImage,
      ];

  RegisterKetuaState copyWith({
    String? name,
    LatLng? registerLocation,
    String? registerAddress,
    String? province,
    String? city,
    String? subDistrict,
    String? postalCode,
    String? district,
    SelectedAdministration? selectedAdministration,
    bool? loading,
    double? latitude,
    double? longitude,
    String? currentAddress,
    File? fileImage,
  }) {
    return RegisterKetuaState(
      registerLocation: registerLocation ?? this.registerLocation,
      district: district ?? this.district,
      registerAddress: registerAddress ?? this.registerAddress,
      province: province ?? this.province,
      city: city ?? this.city,
      subDistrict: subDistrict ?? this.subDistrict,
      postalCode: postalCode ?? this.postalCode,
      selectedAdministration:
          selectedAdministration ?? this.selectedAdministration,
      loading: loading ?? this.loading,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      currentAddress: currentAddress ?? this.currentAddress,
      fileImage: fileImage ?? this.fileImage,
      name: name ?? this.name,
    );
  }
}
