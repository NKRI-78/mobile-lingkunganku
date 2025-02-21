import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/management_repository/management_repository.dart';
import '../../../repositories/management_repository/models/management_member_model.dart';

part 'management_state.dart';

class ManagementCubit extends Cubit<ManagementState> {
  ManagementCubit() : super(const ManagementState());

  ManagementRepository repo = ManagementRepository();

  Future<void> fetchManagementMembers() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final members = await repo.getMember();

      emit(state.copyWith(isLoading: false, memberData: members));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Gagal memuat data: $e",
      ));
    }
  }
}
