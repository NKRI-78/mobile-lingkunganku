class PaymentChannelModel {
  int? id;
  String? paymentType;
  String? name;
  String? nameCode;
  String? logo;
  int? fee;
  String? serviceFee;
  String? platform;
  String? howToUseUrl;
  User? user;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  PaymentChannelModel(
      {this.id,
      this.paymentType,
      this.name,
      this.nameCode,
      this.logo,
      this.fee,
      this.serviceFee,
      this.platform,
      this.howToUseUrl,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  PaymentChannelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentType = json['paymentType'];
    name = json['name'];
    nameCode = json['nameCode'];
    logo = json['logo'];
    fee = json['fee'];
    serviceFee = json['service_fee'];
    platform = json['platform'];
    howToUseUrl = json['howToUseUrl'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['paymentType'] = paymentType;
    data['name'] = name;
    data['nameCode'] = nameCode;
    data['logo'] = logo;
    data['fee'] = fee;
    data['service_fee'] = serviceFee;
    data['platform'] = platform;
    data['howToUseUrl'] = howToUseUrl;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    return data;
  }
}

class User {
  int? balance;

  User({this.balance});

  User.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = balance;
    return data;
  }
}
