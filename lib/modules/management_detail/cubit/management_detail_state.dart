part of 'management_detail_cubit.dart';

class ManagementDetailState extends Equatable {
  final bool isLoading;
  final Members? memberDetail;
  final String? errorMessage;

  const ManagementDetailState({
    this.isLoading = false,
    this.memberDetail,
    this.errorMessage,
  });

  ManagementDetailState copyWith({
    bool? isLoading,
    Members? memberDetail,
    String? errorMessage,
  }) {
    return ManagementDetailState(
      isLoading: isLoading ?? this.isLoading,
      memberDetail: memberDetail ?? this.memberDetail,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, memberDetail, errorMessage];
}
