part of 'wallet_cubit.dart';

class WalletState extends Equatable {
  final List<PaymentChannelModel> channels;
  final PaymentChannelModel? channel;
  final double amount;
  final int selectedCard;
  final bool loading;
  final bool loadingChannel;
  final ProfileModel? profile;
  final double adminFee;
  final double totalAmount;
  final bool isLoading;

  const WalletState({
    this.isLoading = false,
    this.amount = 0.0,
    this.selectedCard = -1,
    this.loading = false,
    this.loadingChannel = false,
    this.channels = const [],
    this.channel,
    this.profile,
    this.adminFee = 0.0,
    this.totalAmount = 0.0,
  });

  @override
  List<Object?> get props => [
        isLoading,
        channels,
        channel,
        amount,
        selectedCard,
        loading,
        loadingChannel,
        profile,
        adminFee,
        totalAmount,
      ];

  WalletState copyWith({
    bool? isLoading,
    List<PaymentChannelModel>? channels,
    PaymentChannelModel? channel,
    double? amount,
    int? selectedCard,
    bool? loading,
    bool? loadingChannel,
    ProfileModel? profile,
    double? adminFee,
    double? totalAmount,
  }) {
    return WalletState(
      channels: channels ?? this.channels,
      channel: channel ?? this.channel,
      amount: amount ?? this.amount,
      selectedCard: selectedCard ?? this.selectedCard,
      loading: loading ?? this.loading,
      loadingChannel: loadingChannel ?? this.loadingChannel,
      profile: profile ?? this.profile,
      adminFee: adminFee ?? this.adminFee,
      isLoading: isLoading ?? this.isLoading,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
