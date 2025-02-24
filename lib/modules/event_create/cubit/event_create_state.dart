part of 'event_create_cubit.dart';

final class EventCreateState extends Equatable {
  final List<EventModel>? events;
  final String errorMessage;
  final bool isLoading;
  final File? fileImage;
  final String title;
  final String description;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? address;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? neighborhoodId;
  final String? userId;

  const EventCreateState({
    this.events = const [],
    this.errorMessage = '',
    this.isLoading = false,
    this.fileImage,
    this.title = '',
    this.description = '',
    this.startTime,
    this.endTime,
    this.address,
    this.startDate,
    this.endDate,
    this.neighborhoodId,
    this.userId,
  });

  EventCreateState copyWith({
    List<EventModel>? events,
    String? errorMessage,
    bool? isLoading,
    ValueGetter<File?>? fileImage,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? address,
    ValueGetter<DateTime>? startDate,
    ValueGetter<DateTime>? endDate,
    String? neighborhoodId,
    String? userId,
  }) {
    return EventCreateState(
      events: events ?? this.events,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      fileImage: fileImage != null ? fileImage() : this.fileImage,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      address: address ?? this.address,
      startDate: startDate != null ? startDate() : this.startDate,
      endDate: endDate != null ? endDate() : this.endDate,
      neighborhoodId: neighborhoodId ?? this.neighborhoodId,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [
        events,
        errorMessage,
        isLoading,
        fileImage,
        title,
        description,
        startTime,
        endTime,
        address,
        startDate,
        endDate,
        neighborhoodId,
        userId,
      ];
}
