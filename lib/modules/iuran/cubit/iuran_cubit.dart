import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/injections.dart';
import '../../../repositories/iuran_repository/iuran_repository.dart';
import '../../../repositories/iuran_repository/models/iuran_model.dart';

part 'iuran_state.dart';

class IuranCubit extends Cubit<IuranState> {
  IuranCubit() : super(const IuranState());

  final IuranRepository repoIuran = getIt<IuranRepository>();

  Future<void> getInvoice() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final invoice = await repoIuran.getInvoice();
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
}
