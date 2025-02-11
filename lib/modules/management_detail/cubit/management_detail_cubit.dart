import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/management_repository.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/models/management_member_model.dart';

part 'management_detail_state.dart';

class ManagementDetailCubit extends Cubit<ManagementDetailState> {
  final ManagementRepository repository;

  ManagementDetailCubit(this.repository) : super(const ManagementDetailState());

  Future<void> fetchManagementDetailMembers({required String userId}) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      print("Fetching member detail for userId: $userId");

      final memberDetail = await repository.getMemberDetail(userId);

      // Debugging untuk memastikan data diterima
      print("Data member diterima: ${memberDetail.profile?.fullname}");

      emit(state.copyWith(
        isLoading: false,
        memberDetail: memberDetail,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Gagal memuat data: $e",
      ));
    }
  }
}
