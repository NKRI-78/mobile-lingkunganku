part of 'profile_update_cubit.dart';

class ProfileUpdateState extends Equatable {
  final ProfileModel? profile;
  final String fullname;
  final String phone;
  final String linkAvatar;
  final bool isLoading;
  final String successMessage;
  final String? errorMessage;

  const ProfileUpdateState({
    this.profile,
    this.fullname = '',
    this.phone = '',
    this.linkAvatar = '',
    this.isLoading = false,
    this.successMessage = '',
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        profile,
        fullname,
        phone,
        linkAvatar,
        isLoading,
        successMessage,
        errorMessage,
      ];

  ProfileUpdateState copyWith({
    ProfileModel? profile,
    String? fullname,
    String? phone,
    String? linkAvatar,
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
  }) {
    return ProfileUpdateState(
      profile: profile ?? this.profile,
      fullname: fullname ?? this.fullname,
      phone: phone ?? this.phone,
      linkAvatar: linkAvatar ?? this.linkAvatar,
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
