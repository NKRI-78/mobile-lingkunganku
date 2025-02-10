import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/management_repository.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/models/management_member_model.dart';

part 'management_state.dart';

class ManagementCubit extends Cubit<ManagementState> {
  final ManagementRepository repository;

  ManagementCubit(this.repository) : super(const ManagementState());

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
}
