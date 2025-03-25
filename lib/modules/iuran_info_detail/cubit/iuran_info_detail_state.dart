part of 'iuran_info_detail_cubit.dart';

class IuranInfoDetailState extends Equatable {
  final String? errorMessage;
  final bool isLoading;
  final ContributeModel? contribute;

  const IuranInfoDetailState({
    this.errorMessage,
    this.isLoading = false,
    this.contribute,
  });

  IuranInfoDetailState copyWith({
    bool? isLoading,
    String? errorMessage,
    ContributeModel? contribute,
  }) {
    return IuranInfoDetailState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      contribute: contribute ?? this.contribute,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, contribute];
}
