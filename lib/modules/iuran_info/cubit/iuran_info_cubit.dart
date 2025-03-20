import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../repositories/profile_repository/models/contribute_model.dart';
import '../../../repositories/profile_repository/profile_repository.dart';

part 'iuran_info_state.dart';

class IuranInfoCubit extends Cubit<IuranInfoState> {
  IuranInfoCubit() : super(IuranInfoState());

  ProfileRepository repo = ProfileRepository();

  Future<void> fetchContribute() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      final contribute = await repo.getContribute();

      emit(state.copyWith(isLoading: false, contribute: contribute));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: "Gagal memuat data: $e"));
    }
  }
}
