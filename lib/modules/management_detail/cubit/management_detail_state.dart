part of 'management_detail_cubit.dart';

class ManagementDetailState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final ManagementDetailMemberModel? memberDetail;
  final Members? member;

  const ManagementDetailState({
    this.isLoading = false,
    this.errorMessage,
    this.memberDetail,
    this.member,
  });

  ManagementDetailState copyWith({
    bool? isLoading,
    String? errorMessage,
    ManagementDetailMemberModel? memberDetail,
    Members? member,
  }) {
    return ManagementDetailState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      memberDetail: memberDetail ?? this.memberDetail,
      member: member ?? this.member,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, memberDetail, member];
}
