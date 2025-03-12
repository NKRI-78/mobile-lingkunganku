class PaymentChannelModel {
  int? id;
  String? paymentType;
  String? name;
  String? nameCode;
  String? logo;
  String? platform;
  String? howToUseUrl;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  PaymentChannelModel(
      {this.id,
      this.paymentType,
      this.name,
      this.nameCode,
      this.logo,
      this.platform,
      this.howToUseUrl,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  PaymentChannelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentType = json['paymentType'];
    name = json['name'];
    nameCode = json['nameCode'];
    logo = json['logo'];
    platform = json['platform'];
    howToUseUrl = json['howToUseUrl'];
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
    data['platform'] = platform;
    data['howToUseUrl'] = howToUseUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    return data;
  }
}
