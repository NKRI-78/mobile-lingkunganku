part of 'management_cubit.dart';

class ManagementState extends Equatable {
  final bool isLoading;
  final ManagementMemberModel? memberData;
  final String? errorMessage;

  const ManagementState({
    this.isLoading = false,
    this.memberData,
    this.errorMessage,
  });

  ManagementState copyWith({
    bool? isLoading,
    ManagementMemberModel? memberData,
    String? errorMessage,
  }) {
    return ManagementState(
      isLoading: isLoading ?? this.isLoading,
      memberData: memberData ?? this.memberData,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, memberData, errorMessage];
}
