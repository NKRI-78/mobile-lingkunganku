part of 'iuran_cubit.dart';

class IuranState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final IuranModel? iuran;

  const IuranState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.iuran,
  });

  IuranState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    IuranModel? iuran,
  }) {
    return IuranState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      iuran: iuran ?? this.iuran,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        iuran,
        successMessage,
      ];
}
