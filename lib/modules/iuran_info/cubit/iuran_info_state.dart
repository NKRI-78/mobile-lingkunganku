part of 'iuran_info_cubit.dart';

class IuranInfoState extends Equatable {
  final String? errorMessage;
  final bool isLoading;
  final ContributeModel? contribute;
  final ManagementMemberModel? memberData;

  const IuranInfoState({
    this.errorMessage,
    this.isLoading = false,
    this.contribute,
    this.memberData,
  });

  IuranInfoState copyWith({
    bool? isLoading,
    String? errorMessage,
    ContributeModel? contribute,
    ManagementMemberModel? memberData,
  }) {
    return IuranInfoState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      contribute: contribute ?? this.contribute,
      memberData: memberData ?? this.memberData,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, contribute, memberData];
}
