class PaymentChannelModelV2 {
  int? id;
  String? paymentType;
  String? name;
  String? nameCode;
  String? logo;
  String? platform;
  int? fee;
  String? serviceFee;
  String? howToUseUrl;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  User? user;

  PaymentChannelModelV2({
    this.id,
    this.paymentType,
    this.name,
    this.nameCode,
    this.logo,
    this.platform,
    this.fee,
    this.serviceFee,
    this.howToUseUrl,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
  });

  PaymentChannelModelV2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentType = json['paymentType'];
    name = json['name'];
    nameCode = json['nameCode'];
    logo = json['logo'];
    platform = json['platform'];
    fee = json['fee'];
    serviceFee = json['service_fee'];
    howToUseUrl = json['howToUseUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['paymentType'] = paymentType;
    data['name'] = name;
    data['nameCode'] = nameCode;
    data['logo'] = logo;
    data['platform'] = platform;
    data['fee'] = fee;
    data['service_fee'] = serviceFee;
    data['howToUseUrl'] = howToUseUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
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
