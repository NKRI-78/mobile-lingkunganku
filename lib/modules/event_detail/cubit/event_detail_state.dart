part of 'event_detail_cubit.dart';

final class EventDetailState extends Equatable {
  final int idEvent;
  final EventDetailModel? event;
  final bool loading;
  final bool success;
  final String? errorMessage;
  final ProfileModel? profile;

  const EventDetailState({
    this.idEvent = 0,
    this.event,
    this.loading = false,
    this.success = false,
    this.errorMessage,
    this.profile,
  });

  EventDetailState copyWith({
    int? idEvent,
    EventDetailModel? event,
    bool? loading,
    bool? success,
    String? errorMessage,
    ProfileModel? profile,
  }) {
    return EventDetailState(
      idEvent: idEvent ?? this.idEvent,
      event: event ?? this.event,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      errorMessage: errorMessage,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props =>
      [idEvent, event, loading, success, errorMessage, profile];
}
