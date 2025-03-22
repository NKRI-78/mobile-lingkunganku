class InquiryModel {
  String? paymentAccess;
  String? paymentType;
  String? orderId;

  InquiryModel({this.paymentAccess, this.paymentType, this.orderId});

  InquiryModel.fromJson(Map<String, dynamic> json) {
    paymentAccess = json['payment_access'];
    paymentType = json['payment_type'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_access'] = paymentAccess;
    data['payment_type'] = paymentType;
    data['order_id'] = orderId;
    return data;
  }
}
