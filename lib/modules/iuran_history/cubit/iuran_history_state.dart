part of 'iuran_history_cubit.dart';

class IuranHistoryState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final List<IuranPaidModel>? iuran;
  final bool loadingChannel;
  final List<Data> selectedInvoices;
  final double adminFee;

  const IuranHistoryState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.iuran,
    this.loadingChannel = false,
    this.selectedInvoices = const [],
    this.adminFee = 0.0,
  });

  IuranHistoryState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    List<IuranPaidModel>? iuran,
    bool? loadingChannel,
    List<Data>? selectedInvoices,
    double? adminFee,
  }) {
    return IuranHistoryState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      iuran: iuran ?? this.iuran,
      loadingChannel: loadingChannel ?? this.loadingChannel,
      selectedInvoices: selectedInvoices ?? this.selectedInvoices,
      adminFee: adminFee ?? this.adminFee,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        iuran,
        successMessage,
        loadingChannel,
        selectedInvoices,
        adminFee,
      ];
}
