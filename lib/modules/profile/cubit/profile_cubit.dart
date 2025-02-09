import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/modules/home/bloc/home_bloc.dart';
import 'package:mobile_lingkunganku/repositories/profile_repository/models/profile_model.dart';
import 'package:mobile_lingkunganku/repositories/profile_repository/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  ProfileRepository repo = ProfileRepository();

  Future<void> getProfile() async {
    try {
      emit(state.copyWith(isLoading: true));
      final profile = await repo.getProfile();
      emit(state.copyWith(
        profile: profile,
      ));
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
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
