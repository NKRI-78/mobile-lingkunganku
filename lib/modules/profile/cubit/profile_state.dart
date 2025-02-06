part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final ProfileModel? profile;

  final bool isLoading;

  const ProfileState({
    this.profile,
    this.isLoading = false,
  });

  ProfileState copyWith({
    ProfileModel? profile,
    bool? isLoading,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [isLoading, profile];
}
