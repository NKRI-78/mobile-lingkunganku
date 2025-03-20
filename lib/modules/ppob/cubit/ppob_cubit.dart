import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../misc/injections.dart';
import '../../../repositories/ppob_repository/ppob_repository.dart';

import '../../../repositories/ppob_repository/models/pulsa_data_model.dart';

part 'ppob_state.dart';

class PpobCubit extends Cubit<PpobState> {
  PpobCubit() : super(const PpobState());

  PpobRepository repo = getIt<PpobRepository>();

  Future<void> fetchPulsaData(
      {required String prefix, required String type}) async {
    print("📡 Calling API with prefix: $prefix, type: $type");

    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: null));

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

  // 🔹 Fungsi untuk menghapus data saat kategori LISTRIK dipilih
  void clearPulsaData() {
    emit(state.copyWith(pulsaData: [], isSuccess: null, errorMessage: null));
  }
}
