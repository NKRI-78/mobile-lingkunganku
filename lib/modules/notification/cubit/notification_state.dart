part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final Pagination? pagination;
  final List<NotificationModel> notif;
  final List<NotificationV2Model> inboxNotif;
  final int nextPageNotif;
  final bool loading;
  final NotificationDetail? detail;
  final NotificationDetailV2? detailv2;
  final int idNotif;
  final List<PaymentChannelModelV2> channels;
  final PaymentChannelModelV2? channel;

  const NotificationState({
    required this.pagination,
    this.loading = false,
    this.notif = const [],
    this.inboxNotif = const [],
    this.nextPageNotif = 1,
    this.detail,
    this.detailv2,
    this.idNotif = 0,
    this.channels = const [],
    this.channel,
  });

  @override
  List<Object?> get props => [
        pagination,
        notif,
        loading,
        nextPageNotif,
        detail,
        idNotif,
        inboxNotif,
        detailv2,
        channels,
        channel,
      ];

  NotificationState copyWith({
    Pagination? pagination,
    List<NotificationModel>? notif,
    List<NotificationV2Model>? inboxNotif,
    bool? loading,
    int? nextPageNotif,
    final NotificationDetail? detail,
    final int? idNotif,
    final NotificationDetailV2? detailv2,
    List<PaymentChannelModelV2>? channels,
    PaymentChannelModelV2? channel,
  }) {
    return NotificationState(
      pagination: pagination ?? this.pagination,
      notif: notif ?? this.notif,
      inboxNotif: inboxNotif ?? this.inboxNotif,
      loading: loading ?? this.loading,
      nextPageNotif: nextPageNotif ?? this.nextPageNotif,
      detail: detail ?? this.detail,
      idNotif: idNotif ?? this.idNotif,
      detailv2: detailv2 ?? this.detailv2,
      channels: channels ?? this.channels,
      channel: channel ?? this.channel,
    );
  }
}
