import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/families_model.dart';
import '../../../misc/injections.dart';
import '../../home/bloc/home_bloc.dart';
import '../../../repositories/profile_repository/models/profile_model.dart';
import '../../../repositories/profile_repository/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  ProfileRepository repo = ProfileRepository();

//   void updatePhoneSecurity(String newPhone) {
//   emit(state.copyWith(
//     profile: state.profile?.copyWith(
//       neighborhood: state.profile?.neighborhood?.copyWith(phoneSecurity: newPhone),
//     ),
//   ));
// }

  Future<void> getProfile() async {
    try {
      emit(state.copyWith(isLoading: true));

      final profile = await repo.getProfile();
      print("Families Data: ${profile.families}");

      emit(state.copyWith(
        profile: profile,
        families: profile.families,
      ));
    } catch (e) {
      emit(state.copyWith(errorMessage: "Gagal memuat profil: $e"));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> updatePhoneSecurity(String phoneSecurity) async {
    try {
      emit(state.copyWith(isLoading: true));

      final neighborhoodId = state.profile?.neighborhood?.id.toString();
      if (neighborhoodId == null) {
        throw "Neighborhood ID tidak ditemukan!";
      }

      await repo.updatePhoneSecurity(
        neighborhoodId: neighborhoodId,
        phoneSecurity: phoneSecurity,
      );

      await getProfile(); // Fetch ulang data agar UI terupdate

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    if (getIt.isRegistered<HomeBloc>()) {
      getIt<HomeBloc>().add(HomeInit());
    }
    return super.close();
  }
}
