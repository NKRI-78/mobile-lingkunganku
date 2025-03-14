import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/injections.dart';
import '../../../repositories/iuran_repository/iuran_repository.dart';
import '../../../repositories/iuran_repository/models/iuran_model.dart';
import '../../../repositories/iuran_repository/models/payment_channel_model.dart';

part 'iuran_history_state.dart';

class IuranHistoryCubit extends Cubit<IuranHistoryState> {
  IuranHistoryCubit() : super(const IuranHistoryState());

  final IuranRepository repo = getIt<IuranRepository>();

  Future<void> getPaidInvoices() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final invoice = await repo.getPaidInvoices();
      emit(state.copyWith(isLoading: false, iuran: invoice));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Gagal memuat invoice: $e",
      ));
    }
  }
}
