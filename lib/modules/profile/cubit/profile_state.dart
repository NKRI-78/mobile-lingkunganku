part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final String chiefReferral;
  final String familyReferral;
  final bool isLoading;
  final String? errorMessage;

  const ProfileState({
    required this.chiefReferral,
    required this.familyReferral,
    this.isLoading = false,
    this.errorMessage,
  });

  ProfileState copyWith({
    String? chiefReferral,
    String? familyReferral,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProfileState(
      chiefReferral: chiefReferral ?? this.chiefReferral,
      familyReferral: familyReferral ?? this.familyReferral,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [chiefReferral, familyReferral, isLoading, errorMessage];
}
