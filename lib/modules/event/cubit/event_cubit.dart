import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../misc/injections.dart';
import '../../../repositories/event_repository/event_repository.dart';
import '../../../repositories/profile_repository/profile_repository.dart';

import '../../../repositories/event_repository/models/event_model.dart';
import '../../../repositories/profile_repository/models/profile_model.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(const EventState()) {
    fetchEvent();
  }

  EventRepository repo = getIt<EventRepository>();
  ProfileRepository repoProfile = getIt<ProfileRepository>();

  void copyState({required EventState newState}) {
    emit(newState);
  }

  Future<void> fetchEvent() async {
    emit(state.copyWith(isLoading: true));
    try {
      emit(state.copyWith(isLoading: true));
      final event = await repo.getEvents();
      final profile = await repoProfile.getProfile();
      emit(state.copyWith(
        events: event,
        profile: profile,
        isLoading: false,
      ));
      debugPrint("Event berhasil dimuat: $event");
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
      debugPrint("Gagal memuat event: $e");
    }
  }
}
