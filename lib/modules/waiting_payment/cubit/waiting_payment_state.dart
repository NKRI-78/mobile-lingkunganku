// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'waiting_payment_cubit.dart';

class WaitingPaymentState extends Equatable {
  final PaymentModel? payment;
  final bool loading;

  const WaitingPaymentState({
    this.payment,
    this.loading = true,
  });

  @override
  List<Object?> get props => [payment, loading];

  WaitingPaymentState copyWith({
    PaymentModel? payment,
    bool? loading,
  }) {
    return WaitingPaymentState(
      payment: payment ?? this.payment,
      loading: loading ?? this.loading,
    );
  }
}
