part of 'ppob_cubit.dart';

class PpobState extends Equatable {
  final List<PulsaDataModel> pulsaData;
  final String? errorMessage;
  final bool isLoading;
  final bool? isSuccess;
  final bool loadingChannel;
  final List<PaymentChannelModelV2> channels;
  final PaymentChannelModelV2? channel;
  final double adminFee;
  final PulsaDataModel? selectedPulsaData;
  final String? selectedType;
  final String? idpel;
  final String? paymentCode;

  const PpobState({
    this.pulsaData = const [],
    this.errorMessage,
    this.isLoading = false,
    this.isSuccess,
    this.loadingChannel = false,
    this.channels = const [],
    this.channel,
    this.adminFee = 0.0,
    this.selectedPulsaData,
    this.selectedType,
    this.idpel,
    this.paymentCode,
  });

  @override
  List<Object?> get props => [
        pulsaData,
        errorMessage,
        isLoading,
        isSuccess,
        loadingChannel,
        channels,
        channel,
        adminFee,
        selectedPulsaData,
        selectedType,
        idpel,
        paymentCode,
      ];

  PpobState copyWith({
    List<PulsaDataModel>? pulsaData,
    String? errorMessage,
    bool? isLoading,
    bool? isSuccess,
    bool? loadingChannel,
    List<PaymentChannelModelV2>? channels,
    PaymentChannelModelV2? channel,
    double? adminFee,
    PulsaDataModel? selectedPulsaData,
    String? selectedType,
    String? idpel,
    String? paymentCode,
  }) {
    return PpobState(
      pulsaData: pulsaData ?? this.pulsaData,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      loadingChannel: loadingChannel ?? this.loadingChannel,
      channels: channels ?? this.channels,
      channel: channel ?? this.channel,
      adminFee: adminFee ?? this.adminFee,
      selectedPulsaData: selectedPulsaData ?? this.selectedPulsaData,
      selectedType: selectedType ?? this.selectedType,
      idpel: idpel ?? this.idpel,
      paymentCode: paymentCode ?? this.paymentCode,
    );
  }
}
