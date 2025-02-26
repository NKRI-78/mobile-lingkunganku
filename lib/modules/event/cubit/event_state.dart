part of 'event_cubit.dart';

final class EventState extends Equatable {
  final List<EventModel>? events;
  final String errorMessage;
  final bool isLoading;
  final ProfileModel? profile;

  const EventState({
    this.events,
    this.errorMessage = "",
    this.isLoading = false,
    this.profile,
  });

  EventState copyWith({
    List<EventModel>? events,
    String? errorMessage,
    bool? isLoading,
    ProfileModel? profile,
  }) {
    return EventState(
      events: events ?? this.events,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [
        events,
        errorMessage,
        isLoading,
        profile,
      ];
}
