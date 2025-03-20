import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/injections.dart';
import '../../../repositories/event_repository/event_repository.dart';
import '../../../repositories/event_repository/models/event_detail_model.dart';
import '../../../repositories/profile_repository/models/profile_model.dart';
import '../../../repositories/profile_repository/profile_repository.dart';
import '../../event/cubit/event_cubit.dart';

part 'event_detail_state.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  EventDetailCubit() : super(EventDetailState());

  EventRepository repo = getIt<EventRepository>();
  ProfileRepository repoProfile = getIt<ProfileRepository>();

  void copyState({required EventDetailState newState}) {
    emit(newState);
  }

  Future<void> fetchDetailEvent(int idEvent) async {
    emit(state.copyWith(loading: true));
    try {
      final event = await repo.getEventDetail(idEvent);
      final profile = await repoProfile.getProfile();
      emit(state.copyWith(
        event: event,
        idEvent: idEvent,
        profile: profile,
      ));
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> removeEvent(int idEvent) async {
    try {
      emit(state.copyWith(loading: true, errorMessage: null));

      final success = await repo.removeEvent(idEvent);

      if (success) {
        emit(state.copyWith(loading: false, success: true));
      } else {
        emit(state.copyWith(
          loading: false,
          success: false,
          errorMessage: "Gagal menghapus event. Silakan coba lagi.",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        success: false,
        errorMessage: "Terjadi kesalahan: ${e.toString()}",
      ));
    }
  }

  @override
  Future<void> close() {
    getIt<EventCubit>().fetchEvent();
    return super.close();
  }
}
