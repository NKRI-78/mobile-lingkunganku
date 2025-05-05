class ContributeModel {
  List<Contributions>? contributions;
  int? total;

  ContributeModel({this.contributions, this.total});

  ContributeModel.fromJson(Map<String, dynamic> json) {
    if (json['contributions'] != null) {
      contributions = <Contributions>[];
      json['contributions'].forEach((v) {
        contributions!.add(Contributions.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contributions != null) {
      data['contributions'] = contributions!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class Contributions {
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
  User? user;
  String get translateStatus {
    switch (status) {
      case 'paid':
        return 'Lunas';
      default:
        return 'Status tidak tersedia';
    }
  }

  Contributions(
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
      this.deletedAt,
      this.user});

  Contributions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    invoiceNumber = json['invoice_number'];
    invoiceDate = json['invoice_date'];
    dueDate = json['due_date'];
    paidDate = json['paid_date'] ?? "";

    totalAmount = json['total_amount'];
    paidAmount = json['paid_amount'];
    note = json['note'];
    status = json['status'];
    userId = json['user_id'];
    neighborhoodId = json['neighborhood_id'];
    familyId = json['family_id'] ?? 0;
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    deletedAt = json['deleted_at'] ?? "";

    user = json['user'] != null ? User.fromJson(json['user']) : null;
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
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? phone;
  Profile? profile;

  User({this.id, this.email, this.phone, this.profile});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['phone'] = phone;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class Profile {
  int? id;
  String? fullname;
  String? avatarLink;
  String? detailAddress;
  String? gender;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.id,
      this.fullname,
      this.avatarLink,
      this.detailAddress,
      this.gender,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    avatarLink = json['avatar_link'];
    detailAddress = json['detail_address'];
    gender = json['gender'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['avatar_link'] = avatarLink;
    data['detail_address'] = detailAddress;
    data['gender'] = gender;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
