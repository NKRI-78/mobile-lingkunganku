import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/management_repository.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/models/management_detail_member_model.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/models/management_member_model.dart';

part 'management_detail_state.dart';

class ManagementDetailCubit extends Cubit<ManagementDetailState> {
  final ManagementRepository repository;

  ManagementDetailCubit(this.repository) : super(const ManagementDetailState());

  Future<void> fetchManagementDetailMembers({required String userId}) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final memberDetail = await repository.getMemberDetail(userId);

      if (memberDetail.data != null) {
        emit(state.copyWith(
          isLoading: false,
          memberDetail: memberDetail,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: "Data member tidak ditemukan",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Gagal memuat data: $e",
      ));
    }
  }

  Future<void> updateToSecretary(String userId) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      await repository.postMemberSecretary(userId);

      await fetchManagementDetailMembers(userId: userId);

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Gagal mengubah role menjadi SECRETARY: $e",
      ));
    }
  }

  Future<void> updateToTreasure(String userId) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      await repository.postMemberTreasure(userId);

      await fetchManagementDetailMembers(userId: userId);

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Gagal mengubah role menjadi TREASURER: $e",
      ));
    }
  }

  Future<void> removeMember(String userId) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      await repository.removeMember(userId);
      await fetchManagementDetailMembers(userId: userId);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Terjadi kesalahan saat menghapus anggota: $e",
      ));
    }
  }
}
