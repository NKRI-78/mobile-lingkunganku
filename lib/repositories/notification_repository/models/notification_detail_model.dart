class NotificationDetail {
  int? id;
  String? type;
  Data? data;
  int? notifiableId;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  NotificationDetail(
      {this.id,
      this.type,
      this.data,
      this.notifiableId,
      this.readAt,
      this.createdAt,
      this.updatedAt});

  NotificationDetail.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'];

    id = dataJson['id'];
    type = dataJson['type'];
    data = dataJson['data'] != null ? Data.fromJson(dataJson['data']) : null;
    notifiableId = dataJson['notifiable_id'];
    readAt = dataJson['read_at'];
    createdAt = dataJson['created_at'];
    updatedAt = dataJson['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['notifiable_id'] = notifiableId;
    data['read_at'] = readAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Data {
  String? title;
  String? message;
  int? userId;
  String? latitude;
  String? longitude;
  String? body;

  Data(
      {this.title,
      this.message,
      this.userId,
      this.latitude,
      this.longitude,
      this.body});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['message'] = message;
    data['user_id'] = userId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['body'] = body;
    return data;
  }
}
