part of 'iuran_cubit.dart';

class IuranState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final IuranModel? iuran;
  final bool loadingChannel;
  final List<PaymentChannelModel> channels;
  final PaymentChannelModel? channel;
  final List<Data> selectedInvoices;
  final double adminFee;

  const IuranState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.iuran,
    this.loadingChannel = false,
    this.channels = const [],
    this.channel,
    this.selectedInvoices = const [],
    this.adminFee = 0.0,
  });

  IuranState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    IuranModel? iuran,
    bool? loadingChannel,
    List<PaymentChannelModel>? channels,
    PaymentChannelModel? channel,
    List<Data>? selectedInvoices,
    double? adminFee,
  }) {
    return IuranState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      iuran: iuran ?? this.iuran,
      loadingChannel: loadingChannel ?? this.loadingChannel,
      channels: channels ?? this.channels,
      channel: channel ?? this.channel,
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
        channels,
        channel,
        selectedInvoices,
        adminFee,
      ];
}
