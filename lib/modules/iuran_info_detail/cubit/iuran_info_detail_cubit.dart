import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/profile_repository/models/contribute_model.dart';
import '../../../repositories/profile_repository/profile_repository.dart';

part 'iuran_info_detail_state.dart';

class IuranInfoDetailCubit extends Cubit<IuranInfoDetailState> {
  IuranInfoDetailCubit() : super(IuranInfoDetailState());

  ProfileRepository repo = ProfileRepository();

  Future<void> fetchContribute(String userId) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final contribute = await repo.getContribute(userId);

      emit(state.copyWith(isLoading: false, contribute: contribute));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: "Gagal memuat data: $e"));
    }
  }
}
