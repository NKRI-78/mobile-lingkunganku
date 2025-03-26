import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/select_payment_channel.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../repositories/iuran_repository/iuran_repository.dart';
import '../../../repositories/iuran_repository/models/iuran_model.dart';
import '../../../repositories/iuran_repository/models/payment_channel_model.dart';

part 'iuran_state.dart';

class IuranCubit extends Cubit<IuranState> {
  IuranCubit() : super(const IuranState());

  final IuranRepository repo = getIt<IuranRepository>();

  void updateSelectedInvoices(List<Data> selected) {
    emit(state.copyWith(selectedInvoices: selected));
  }

  /// **Memilih metode pembayaran dan menyimpan fee (biaya admin)**
  void selectPaymentMethod(PaymentChannelModel channel) {
    emit(state.copyWith(
      channel: channel,
      adminFee: (channel.fee ?? 0).toDouble(),
    ));
  }

  /// **Mengambil daftar invoice**
  Future<void> getInvoice() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final invoice = await repo.getInvoice();
      emit(state.copyWith(
        isLoading: false,
        iuran: invoice,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Gagal memuat invoice: $e",
      ));
    }
  }

  /// **Mengambil daftar metode pembayaran dan menampilkan modal**
  Future<void> getPaymentChannel(BuildContext context) async {
    try {
      emit(state.copyWith(loadingChannel: true));
      var channels = await repo.getChannels();

      if (context.mounted) {
        showModalBottomSheet(
          context: context,
          builder: (_) => BlocProvider<IuranCubit>.value(
            value: context.read<IuranCubit>(),
            child: SelectPaymentChannel(),
          ),
        );
      }

      emit(state.copyWith(channels: channels, loadingChannel: false));
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.redColor,
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    } finally {
      emit(state.copyWith(loadingChannel: false));
    }
  }

  /// **Menyimpan metode pembayaran yang dipilih**
  void setPaymentChannel(PaymentChannelModel channel) {
    emit(state.copyWith(
      channel: channel,
      adminFee:
          (channel.fee ?? 0).toDouble(), // Simpan fee dari metode pembayaran
    ));
  }

  /// **Checkout pembayaran iuran**
  Future<String> checkoutItem() async {
    try {
      emit(state.copyWith(isLoading: true));

      if (state.channel == null) {
        throw Exception("Silakan pilih metode pembayaran terlebih dahulu.");
      }

      var invoiceIds =
          state.selectedInvoices.map((e) => e.id).whereType<int>().toList();

      if (invoiceIds.isEmpty) {
        throw Exception("Tidak ada invoice yang dipilih.");
      }

      debugPrint("Checkout dengan Invoice IDs: $invoiceIds");
      debugPrint("Metode Pembayaran: ${state.channel?.name}");
      debugPrint("Biaya Admin: ${state.adminFee}");

      var paymentNumber = await repo.checkoutItem(
        payment: state.channel!,
        invoiceIds: invoiceIds,
      );

      emit(state.copyWith(isLoading: false, selectedInvoices: []));
      return paymentNumber;
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      throw Exception("Checkout gagal: $e");
    }
  }
}
