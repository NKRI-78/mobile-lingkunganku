class PaymentModel {
  Map? data;
  int? id;
  String? paymentNumber;
  String? type;
  String? name;
  String? code;
  String? logoUrl;
  String? platform;
  int? price;
  int? totalPrice;
  int? fee;
  String? status;
  String? expireAt;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? paymentType;
  List<Invoices>? invoices;

  PaymentModel({
    this.data,
    this.id,
    this.paymentNumber,
    this.type,
    this.name,
    this.code,
    this.logoUrl,
    this.platform,
    this.price,
    this.totalPrice,
    this.fee,
    this.status,
    this.expireAt,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.paymentType,
    this.invoices,
  });

  PaymentModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    id = json['id'];
    paymentNumber = json['payment_number'];
    type = json['type'];
    name = json['name'];
    code = json['code'];
    logoUrl = json['logo_url'];
    platform = json['platform'];
    price = json['price'];
    totalPrice = json['total_price'];
    fee = json['fee'];
    status = json['status'];
    expireAt = json['expire_at'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    paymentType = json['payment_type'];
    if (json['invoices'] != null) {
      invoices = <Invoices>[];
      json['invoices'].forEach((v) {
        invoices!.add(Invoices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['id'] = id;
    data['payment_number'] = paymentNumber;
    data['type'] = type;
    data['name'] = name;
    data['code'] = code;
    data['logo_url'] = logoUrl;
    data['platform'] = platform;
    data['price'] = price;
    data['total_price'] = totalPrice;
    data['fee'] = fee;
    data['status'] = status;
    data['expire_at'] = expireAt;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['payment_type'] = paymentType;
    if (invoices != null) {
      data['invoices'] = invoices!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Invoices {
  int? id;
  String? name;
  String? invoiceNumber;
  String? invoiceDate;
  String? dueDate;
  String? paidDate;
  int? totalAmount;
  int? paidAmount;
  String? note;
  String? status;
  int? userId;
  int? neighborhoodId;
  int? familyId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Invoices(
      {this.id,
      this.name,
      this.invoiceNumber,
      this.invoiceDate,
      this.dueDate,
      this.paidDate,
      this.totalAmount,
      this.paidAmount,
      this.note,
      this.status,
      this.userId,
      this.neighborhoodId,
      this.familyId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Invoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    invoiceNumber = json['invoice_number'];
    invoiceDate = json['invoice_date'];
    dueDate = json['due_date'];
    paidDate = json['paid_date'];
    totalAmount = json['total_amount'];
    paidAmount = json['paid_amount'];
    note = json['note'];
    status = json['status'];
    userId = json['user_id'];
    neighborhoodId = json['neighborhood_id'];
    familyId = json['family_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['invoice_number'] = invoiceNumber;
    data['invoice_date'] = invoiceDate;
    data['due_date'] = dueDate;
    data['paid_date'] = paidDate;
    data['total_amount'] = totalAmount;
    data['paid_amount'] = paidAmount;
    data['note'] = note;
    data['status'] = status;
    data['user_id'] = userId;
    data['neighborhood_id'] = neighborhoodId;
    data['family_id'] = familyId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
