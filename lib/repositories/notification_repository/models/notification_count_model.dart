class NotificationCountModel {
  int? unreadCount;

  NotificationCountModel({this.unreadCount});

  NotificationCountModel.fromJson(Map<String, dynamic> json) {
    unreadCount = json['unreadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unreadCount'] = unreadCount;
    return data;
  }
}
