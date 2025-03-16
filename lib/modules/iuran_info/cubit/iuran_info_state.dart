part of 'iuran_info_cubit.dart';

class IuranInfoState extends Equatable {
  final String? errorMessage;
  final bool isLoading;
  final ContributeModel? contribute;

  const IuranInfoState({
    this.errorMessage,
    this.isLoading = false,
    this.contribute,
  });

  IuranInfoState copyWith({
    bool? isLoading,
    String? errorMessage,
    ContributeModel? contribute,
  }) {
    return IuranInfoState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      contribute: contribute ?? this.contribute,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, contribute];
}
