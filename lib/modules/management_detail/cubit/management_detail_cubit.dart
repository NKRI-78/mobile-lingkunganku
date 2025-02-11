import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/management_repository.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/models/management_member_model.dart';
part 'management_detail_state.dart';

class ManagementDetailCubit extends Cubit<ManagementDetailState> {
  final ManagementRepository repository;

  ManagementDetailCubit(this.repository) : super(const ManagementDetailState());

  Future<void> fetchManagementDetailMembers() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final members = await repository.getMember();
      emit(state.copyWith(isLoading: false, memberDetail: members));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Gagal memuat data: $e",
      ));
    }
  }
}
