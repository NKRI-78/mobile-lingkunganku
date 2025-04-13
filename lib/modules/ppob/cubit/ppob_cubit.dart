import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/select_payment_channel.dart';
import '../../../repositories/ppob_repository/models/payment_channel_modelv2.dart';
import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../repositories/ppob_repository/ppob_repository.dart';

import '../../../repositories/ppob_repository/models/pulsa_data_model.dart';

part 'ppob_state.dart';

class PpobCubit extends Cubit<PpobState> {
  PpobCubit() : super(const PpobState());

  PpobRepository repo = getIt<PpobRepository>();
  String? _currentType;

  void copyState({required PpobState newState}) {
    emit(newState);
  }

  Future<void> fetchPulsaData(
      {required String prefix, required String type}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: null));
    _currentType = type;

    try {
      final data = await repo.fetchPulsaData(prefix: prefix, type: type);

      emit(state.copyWith(
        pulsaData: data,
        isLoading: false,
        isSuccess: true,
        errorMessage: null,
      ));
    } catch (e) {
      debugPrint("❌ Error fetching pulsa data: $e");

      emit(state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
        isSuccess: false,
      ));
    }
  }

  /// **Getter untuk mendapatkan type yang terakhir digunakan**
  String? get currentType => _currentType;

  Future<void> getPaymentChannel(BuildContext context) async {
    try {
      emit(state.copyWith(loadingChannel: true));
      var channels = await repo.getChannels();

      if (context.mounted) {
        showModalBottomSheet(
          context: context,
          builder: (_) => BlocProvider<PpobCubit>.value(
            value: context.read<PpobCubit>(),
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

  Future<Map<String, dynamic>?> checkoutItem(
      String userId, String type, String idPel) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      if (state.channel == null) {
        throw Exception("Silakan pilih metode pembayaran terlebih dahulu.");
      }
      if (state.selectedPulsaData == null) {
        throw Exception("Silakan pilih produk pulsa atau data.");
      }

      final PulsaDataModel selectedProduct = state.selectedPulsaData!;

      final Map<String, dynamic> paymentData = await repo.checkoutItem(
        idPel: idPel,
        userId: userId,
        productId: selectedProduct.code ?? "",
        paymentChannel: state.channel?.id ?? 0,
        paymentCode: state.channel?.nameCode ?? "",
        type: type,
      );

      debugPrint("Checkout Success: $paymentData");

      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
      ));

      return paymentData;
    } catch (e) {
      debugPrint("Checkout Error: $e");

      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));

      return null;
    }
  }

  /// **Menyimpan metode pembayaran yang dipilih**
  void setPaymentChannel(PaymentChannelModelV2 channel) {
    emit(state.copyWith(
      channel: channel,
      adminFee:
          (channel.fee ?? 0).toDouble(), // Simpan fee dari metode pembayaran
    ));
  }

  // Fungsi untuk menghapus data saat kategori LISTRIK dipilih
  void clearPulsaData() {
    _currentType = null;
    emit(state.copyWith(pulsaData: [], isSuccess: null, errorMessage: null));
  }
}
