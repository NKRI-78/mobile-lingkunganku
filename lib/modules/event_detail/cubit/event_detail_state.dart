part of 'event_detail_cubit.dart';

final class EventDetailState {
  final int idEvent;
  final EventDetailModel? event;
  final bool loading;

  const EventDetailState({
    this.idEvent = 0,
    this.event,
    this.loading = false,
  });

  EventDetailState copyWith({
    int? idEvent,
    EventDetailModel? event,
    bool? loading,
  }) {
    return EventDetailState(
      idEvent: idEvent ?? this.idEvent,
      event: event ?? this.event,
      loading: loading ?? this.loading,
    );
  }
}
