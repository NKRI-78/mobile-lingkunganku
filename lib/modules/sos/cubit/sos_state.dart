part of 'sos_cubit.dart';

class SosState extends Equatable {
  final ProfileModel? profile;
  final String? errorMessage;
  final bool isLoading;

  const SosState({
    this.errorMessage,
    this.profile,
    this.isLoading = false,
  });

  SosState copyWith({
    ProfileModel? profile,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SosState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, profile, errorMessage];
}
