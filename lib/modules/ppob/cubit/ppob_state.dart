part of 'ppob_cubit.dart';

class PpobState extends Equatable {
  final List<PulsaDataModel> pulsaData;
  final String? errorMessage;
  final bool isLoading;
  final bool? isSuccess;

  const PpobState({
    this.pulsaData = const [],
    this.errorMessage,
    this.isLoading = false,
    this.isSuccess,
  });

  @override
  List<Object?> get props => [pulsaData, errorMessage, isLoading, isSuccess];

  PpobState copyWith({
    List<PulsaDataModel>? pulsaData,
    String? errorMessage,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return PpobState(
      pulsaData: pulsaData ?? this.pulsaData,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
