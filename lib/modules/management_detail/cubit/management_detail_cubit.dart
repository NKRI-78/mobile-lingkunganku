import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/repositories/iuran_repository/iuran_repository.dart';
import 'package:mobile_lingkunganku/repositories/iuran_repository/models/iuran_model.dart';
import '../../../misc/injections.dart';
import '../../../repositories/profile_repository/models/profile_model.dart';
import '../../../repositories/profile_repository/profile_repository.dart';
import '../../management/cubit/management_cubit.dart';
import '../../../repositories/management_repository/management_repository.dart';
import '../../../repositories/management_repository/models/management_detail_member_model.dart';
import '../../../repositories/management_repository/models/management_member_model.dart';

part 'management_detail_state.dart';

class ManagementDetailCubit extends Cubit<ManagementDetailState> {
  ManagementDetailCubit() : super(const ManagementDetailState()) {
    getProfile();
  }

  final ManagementRepository repository = getIt<ManagementRepository>();
  final ProfileRepository repoProfile = getIt<ProfileRepository>();
  final IuranRepository repoIuran = getIt<IuranRepository>();

  Future<void> createInvoice({
    required int userId,
    required int amount,
    required String description,
  }) async {
    try {
      if (amount <= 0) {
        emit(state.copyWith(
            errorMessage: "Nominal harus berupa angka yang valid!"));
        return;
      }

      emit(state.copyWith(isLoading: true, errorMessage: null));

      final hasUnpaid = await repoIuran.hasUnpaidInvoice(userId);
      if (hasUnpaid) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: "Pengguna masih memiliki invoice yang belum dibayar",
        ));
        return;
      }

      await repoIuran.createInvoice(
        userId: userId,
        amount: amount,
        description: description,
      );

      emit(state.copyWith(
        isLoading: false,
        successMessage: "Invoice berhasil dibuat",
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "$e",
      ));
    }
  }

  Future<void> getProfile() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final profile = await repoProfile.getProfile();

      emit(state.copyWith(
        isLoading: false,
        profile: profile,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Gagal mengambil data profil: $e",
      ));
    }
  }

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

  @override
  Future<void> close() {
    getIt<ManagementCubit>().fetchManagementMembers();
    return super.close();
  }
}
