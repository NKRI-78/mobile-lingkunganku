import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../repositories/management_repository/management_repository.dart';
import '../../../repositories/management_repository/models/management_member_model.dart';
import '../../../repositories/profile_repository/models/contribute_model.dart';

part 'iuran_info_state.dart';

class IuranInfoCubit extends Cubit<IuranInfoState> {
  IuranInfoCubit() : super(IuranInfoState());

  // ProfileRepository repo = ProfileRepository();
  ManagementRepository repoMember = ManagementRepository();

  Future<void> fetchManagementMembers() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final members = await repoMember.getMember();

      emit(state.copyWith(isLoading: false, memberData: members));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Gagal memuat data: $e",
      ));
    }
  }

  // Future<void> fetchContribute() async {
  //   try {
  //     emit(state.copyWith(isLoading: true, errorMessage: null));
  //     final contribute = await repo.getContribute();

  //     emit(state.copyWith(isLoading: false, contribute: contribute));
  //   } catch (e) {
  //     emit(state.copyWith(
  //         isLoading: false, errorMessage: "Gagal memuat data: $e"));
  //   }
  // }
}
