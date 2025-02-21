import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../repositories/management_repository/management_repository.dart';
import '../../../repositories/management_repository/models/management_member_model.dart';

part 'transfer_management_state.dart';

class TransferManagementCubit extends Cubit<TransferManagementState> {
  final ManagementRepository repository;

  TransferManagementCubit(this.repository)
      : super(const TransferManagementState());

  Future<void> fetchManagementMembers() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final members = await repository.getMember();

      emit(state.copyWith(isLoading: false, memberData: members));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Gagal memuat data: $e",
      ));
    }
  }

  Future<void> updateToChief(String userId) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      await repository.postChief(userId);

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Gagal mengubah role menjadi CHIEF: $e",
      ));
    }
  }
}
