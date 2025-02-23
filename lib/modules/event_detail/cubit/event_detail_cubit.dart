import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/repositories/event_repository/event_repository.dart';

import '../../../repositories/event_repository/models/event_detail_model.dart';

part 'event_detail_state.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  EventDetailCubit() : super(EventDetailState());

  EventRepository repo = getIt<EventRepository>();

  void copyState({required EventDetailState newState}) {
    emit(newState);
  }

  Future<void> fetchDetailEvent(int idEvent) async {
    emit(state.copyWith(loading: true));
    try {
      final event = await repo.getEventDetail(idEvent);
      emit(state.copyWith(
        event: event,
        idEvent: idEvent,
      ));
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
