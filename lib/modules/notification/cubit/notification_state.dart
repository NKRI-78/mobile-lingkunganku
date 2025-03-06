part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final Pagination? pagination;
  final List<NotificationModel> notif;
  final int nextPageNotif;
  final bool loading;

  const NotificationState({
    required this.pagination,
    this.loading = false,
    this.notif = const [],
    this.nextPageNotif = 1,
  });

  @override
  List<Object?> get props => [
        pagination,
        notif,
        loading,
        nextPageNotif,
      ];

  NotificationState copyWith({
    Pagination? pagination,
    List<NotificationModel>? notif,
    bool? loading,
    int? nextPageNotif,
  }) {
    return NotificationState(
      pagination: pagination ?? this.pagination,
      notif: notif ?? this.notif,
      loading: loading ?? this.loading,
      nextPageNotif: nextPageNotif ?? this.nextPageNotif,
    );
  }
}
