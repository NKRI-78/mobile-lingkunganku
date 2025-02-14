part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final ProfileModel? profile;
  final String? errorMessage;
  final List<FamiliesModel>? families;

  final bool isLoading;

  const ProfileState({
    this.families,
    this.errorMessage,
    this.profile,
    this.isLoading = false,
  });

  ProfileState copyWith({
    ProfileModel? profile,
    bool? isLoading,
    String? errorMessage,
    List<FamiliesModel>? families,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
      families: families ?? this.families,
    );
  }

  @override
  List<Object?> get props => [isLoading, profile, errorMessage, families];
}
