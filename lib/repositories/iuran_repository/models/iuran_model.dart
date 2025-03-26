class IuranModel {
  String? message;
  List<Data>? data; // Menampung daftar invoice

  IuranModel({this.message, this.data});

  factory IuranModel.fromJson(Map<String, dynamic> json) {
    return IuranModel(
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Data.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class Data {
  int? id;
  String? name;
  String? invoiceNumber;
  String? invoiceDate;
  String? dueDate;
  int? amount;
  int? userId;
  int? neighborhoodId;
  int? familyId;
  String? note;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? totalAmount;
  String get translateStatus {
    switch (status) {
      case 'unpaid':
        return 'Belum Bayar';
      case 'paid':
        return 'Lunas';
      default:
        return 'Status tidak tersedia';
    }
  }

  Data({
    this.id,
    this.name,
    this.invoiceNumber,
    this.invoiceDate,
    this.dueDate,
    this.amount,
    this.userId,
    this.neighborhoodId,
    this.familyId,
    this.note,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.totalAmount,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    invoiceNumber = json['invoice_number'];
    invoiceDate = json['invoice_date'];
    dueDate = json['due_date'];
    amount = json['amount'];
    userId = json['user_id'];
    neighborhoodId = json['neighborhood_id'];
    familyId = json['family_id'];
    note = json['note'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['invoice_number'] = invoiceNumber;
    data['invoice_date'] = invoiceDate;
    data['due_date'] = dueDate;
    data['amount'] = amount;
    data['user_id'] = userId;
    data['neighborhood_id'] = neighborhoodId;
    data['family_id'] = familyId;
    data['note'] = note;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['total_amount'] = totalAmount;
    return data;
  }
}
