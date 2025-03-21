class ContributeModel {
  final List<Contributions> contributions;
  final int total;

  ContributeModel({required this.contributions, required this.total});

  factory ContributeModel.fromJson(Map<String, dynamic> json) {
    return ContributeModel(
      contributions: (json['contributions'] as List?)
              ?.map((v) => Contributions.fromJson(v))
              .toList() ??
          [],
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'contributions': contributions.map((v) => v.toJson()).toList(),
        'total': total,
      };

  ContributeModel copyWith({
    List<Contributions>? contributions,
    int? total,
  }) {
    return ContributeModel(
      contributions: contributions ?? this.contributions,
      total: total ?? this.total,
    );
  }
}

class Contributions {
  final int id;
  final String name;
  final String invoiceNumber;
  final String invoiceDate;
  final String dueDate;
  final String? paidDate;
  final int totalAmount;
  final int paidAmount;
  final String? note;
  final String status;
  final int userId;
  final int neighborhoodId;
  final int familyId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final User? user;
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

  Contributions({
    required this.id,
    required this.name,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.dueDate,
    this.paidDate,
    required this.totalAmount,
    required this.paidAmount,
    this.note,
    required this.status,
    required this.userId,
    required this.neighborhoodId,
    required this.familyId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.user,
  });

  factory Contributions.fromJson(Map<String, dynamic> json) {
    return Contributions(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      invoiceNumber: json['invoice_number'] ?? '',
      invoiceDate: json['invoice_date'] ?? '',
      dueDate: json['due_date'] ?? '',
      paidDate: json['paid_date'],
      totalAmount: json['total_amount'] ?? 0,
      paidAmount: json['paid_amount'] ?? 0,
      note: json['note'],
      status: json['status'] ?? '',
      userId: json['user_id'] ?? 0,
      neighborhoodId: json['neighborhood_id'] ?? 0,
      familyId: json['family_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'invoice_number': invoiceNumber,
        'invoice_date': invoiceDate,
        'due_date': dueDate,
        'paid_date': paidDate,
        'total_amount': totalAmount,
        'paid_amount': paidAmount,
        'note': note,
        'status': status,
        'user_id': userId,
        'neighborhood_id': neighborhoodId,
        'family_id': familyId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
        'user': user?.toJson(),
      };
}

class User {
  final int id;
  final String email;
  final String phone;
  final Profile? profile;

  User({
    required this.id,
    required this.email,
    required this.phone,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'phone': phone,
        'profile': profile?.toJson(),
      };
}

class Profile {
  final int id;
  final String fullname;
  final String? avatarLink;
  final String? detailAddress;
  final int userId;
  final String createdAt;
  final String updatedAt;

  Profile({
    required this.id,
    required this.fullname,
    this.avatarLink,
    this.detailAddress,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] ?? 0,
      fullname: json['fullname'] ?? '',
      avatarLink: json['avatar_link'],
      detailAddress: json['detail_address'],
      userId: json['user_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'avatar_link': avatarLink,
        'detail_address': detailAddress,
        'user_id': userId,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
