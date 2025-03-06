class NotificationModel {
  int? id;
  String? type;
  Data? data;
  int? notifiableId;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  NotificationModel(
      {this.id,
      this.type,
      this.data,
      this.notifiableId,
      this.readAt,
      this.createdAt,
      this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    notifiableId = json['notifiable_id'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
  String? type;
  String? title;
  int? paymentId;
  String? description;
  int? totalPrice;

  Data(
      {this.type,
      this.title,
      this.paymentId,
      this.description,
      this.totalPrice});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    paymentId = int.parse(json['payment_id'].toString());
    description = json['description'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['payment_id'] = paymentId;
    data['description'] = description;
    data['total_price'] = totalPrice;
    return data;
  }
}
