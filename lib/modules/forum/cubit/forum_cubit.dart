import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../misc/injections.dart';
import '../../../repositories/forum_repository/forum_repository.dart';
import '../../../repositories/forum_repository/models/forums_model.dart';
import '../../../repositories/profile_repository/models/profile_model.dart';
import '../../../repositories/profile_repository/profile_repository.dart';

part 'forum_state.dart';

class ForumCubit extends Cubit<ForumState> {
  ForumCubit() : super(const ForumState());

  ForumRepository repo = getIt<ForumRepository>();
  ProfileRepository repoProfile = getIt<ProfileRepository>();

  static RefreshController refreshCtrl = RefreshController();

  void init() {
    fetchForum();
    fetchProfile();
  }

  Future<void> fetchForum() async {
    try {
      emit(state.copyWith(loading: true));
      var value = await repo.getForum();

      emit(state.copyWith(forums: value, loading: false));
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> fetchProfile() async {
    try {
      emit(state.copyWith(loading: true));
      var profile = await repoProfile.getProfile();

      emit(state.copyWith(loading: false, profile: profile));
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> deleteForum({required String idForum}) async {
    try {
      emit(state.copyWith(loading: true));
      await repo.deleteForum(idForum.toString());
      var value = await repo.getForum();
      emit(state.copyWith(
        forums: value,
        loading: false,
      ));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setLikeUnlikeForum({required String idForum}) async {
    try {
      // emit(state.copyWith(loading: true));
      await repo.setLikeUnlikeForum(idForum.toString());
      var value = await repo.getForum();
      emit(state.copyWith(forums: value));
    } catch (e) {
      rethrow;
    }
  }
}
