part of 'management_detail_cubit.dart';

class ManagementDetailState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final ManagementDetailMemberModel? memberDetail;
  final Members? member;
  final ProfileModel? profile;
  final IuranModel? iuran;

  const ManagementDetailState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.memberDetail,
    this.member,
    this.profile,
    this.iuran,
  });

  ManagementDetailState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    ManagementDetailMemberModel? memberDetail,
    Members? member,
    ProfileModel? profile,
    IuranModel? iuran,
  }) {
    return ManagementDetailState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      memberDetail: memberDetail ?? this.memberDetail,
      member: member ?? this.member,
      profile: profile ?? this.profile,
      iuran: iuran ?? this.iuran,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        memberDetail,
        member,
        profile,
        iuran,
        successMessage,
      ];
}
