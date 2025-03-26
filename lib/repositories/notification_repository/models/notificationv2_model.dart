class NotificationV2Model {
  int? id;
  String? title;
  String? description;
  String? field2;
  String? field3;
  String? field4;
  String? field5;
  String? field6;
  String? link;
  bool? isRead;

  String get translateStatus {
    switch (field2) {
      case 'UNPAID':
        return 'Belum Bayar';
      case 'PAID':
        return 'Lunas';
      default:
        return 'Status tidak tersedia';
    }
  }

  NotificationV2Model(
      {this.id,
      this.title,
      this.description,
      this.field2,
      this.field3,
      this.field4,
      this.field5,
      this.field6,
      this.link,
      this.isRead});

  NotificationV2Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    field2 = json['field2'];
    field3 = json['field3'];
    field4 = json['field4'];
    field5 = json['field5'];
    field6 = json['field6'];
    link = json['link'];
    isRead = json['is_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['field2'] = field2;
    data['field3'] = field3;
    data['field4'] = field4;
    data['field5'] = field5;
    data['field6'] = field6;
    data['link'] = link;
    data['is_read'] = isRead;
    return data;
  }
}
