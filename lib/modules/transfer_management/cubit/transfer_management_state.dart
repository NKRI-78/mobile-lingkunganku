part of 'transfer_management_cubit.dart';

class TransferManagementState extends Equatable {
  final bool isLoading;
  final ManagementMemberModel? memberData;
  final String? errorMessage;

  const TransferManagementState({
    this.isLoading = false,
    this.memberData,
    this.errorMessage,
  });

  TransferManagementState copyWith({
    bool? isLoading,
    ManagementMemberModel? memberData,
    String? errorMessage,
  }) {
    return TransferManagementState(
      isLoading: isLoading ?? this.isLoading,
      memberData: memberData ?? this.memberData,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, memberData, errorMessage];
}
