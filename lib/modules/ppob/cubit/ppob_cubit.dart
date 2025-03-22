import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/modules/ppob/widget/select_payment_channel.dart';
import 'package:mobile_lingkunganku/repositories/ppob_repository/models/payment_channel_modelv2.dart';
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
    print("📡 Calling API with prefix: $prefix, type: $type");

    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: null));
    _currentType = type;

    try {
      final data = await repo.fetchPulsaData(prefix: prefix, type: type);
      print("✅ Data fetched successfully: ${data.length} items");

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

  Future<void> checkoutItem(String userId, String type, String idPel) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      if (state.channel == null) {
        throw Exception("Silakan pilih metode pembayaran terlebih dahulu.");
      }
      if (state.selectedPulsaData == null) {
        throw Exception("Silakan pilih produk pulsa atau data.");
      }

      final PulsaDataModel selectedProduct = state.selectedPulsaData!;
      final bool isValidProduct = state.pulsaData
          .any((product) => product.code == selectedProduct.code);
      if (!isValidProduct) {
        throw Exception("Produk yang dipilih tidak tersedia.");
      }

      // 🔹 Ambil response lengkap dari repository
      final Map<String, dynamic> paymentData = await repo.checkoutItem(
        idPel: idPel,
        userId: userId,
        productId: selectedProduct.code ?? "",
        paymentChannel: state.channel?.id ?? 0,
        paymentCode: state.channel?.nameCode ?? "",
        type: type,
      );

      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        paymentAccess: paymentData["payment_access"],
        // orderId: paymentData["order_id"],
        // paymentType: paymentData["payment_type"],
        // rawResponse: paymentData, // 🔹 Simpan raw response
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
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
