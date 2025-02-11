class ManagementMemberModel {
  String? message;
  Data? data;

  ManagementMemberModel({this.message, this.data});

  factory ManagementMemberModel.fromJson(Map<String, dynamic> json) {
    return ManagementMemberModel(
      message: json['message'] as String?,
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class Data {
  int? id;
  String? name;
  String? detailAddress;
  double? latitude;
  double? longitude;
  String? referral;
  String? createdAt;
  List<Members>? members;
  int? totalMember;

  Data({
    this.id,
    this.name,
    this.detailAddress,
    this.latitude,
    this.longitude,
    this.referral,
    this.createdAt,
    this.members,
    this.totalMember,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as int?,
      name: json['name'] as String?,
      detailAddress: json['detail_address'] as String?,
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      referral: json['referral'] as String?,
      createdAt: json['created_at'] as String?,
      members: (json['members'] as List<dynamic>?)
          ?.map((v) => Members.fromJson(v))
          .toList(),
      totalMember: json['total_member'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'detail_address': detailAddress,
      'latitude': latitude,
      'longitude': longitude,
      'referral': referral,
      'created_at': createdAt,
      'members': members?.map((v) => v.toJson()).toList(),
      'total_member': totalMember,
    };
  }
}

class Members {
  int? id;
  String? email;
  String? phone;
  String? createdAt;
  String? treasurer;
  String? secretary; // Fix typo dari `secertary`
  Profile? profile;
  Family? family;
  String? roleApp;

  Members({
    this.id,
    this.email,
    this.phone,
    this.createdAt,
    this.treasurer,
    this.secretary,
    this.profile,
    this.family,
    this.roleApp,
  });

  factory Members.fromJson(Map<String, dynamic> json) {
    return Members(
      id: json['id'] as int?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      createdAt: json['created_at'] as String?,
      treasurer: json['treasurer'] as String?,
      secretary: json['secretary'] as String?,
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      family: json['family'] != null ? Family.fromJson(json['family']) : null,
      roleApp: json['roleApp'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'created_at': createdAt,
      'treasurer': treasurer,
      'secretary': secretary,
      'profile': profile?.toJson(),
      'family': family?.toJson(),
      'roleApp': roleApp,
    };
  }
}

class Profile {
  String? fullname;
  String avatarLink; // Default menjadi string kosong jika null
  String? detailAddress;

  Profile({this.fullname, this.avatarLink = "", this.detailAddress});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      fullname: json['fullname'] as String?,
      avatarLink: json['avatar_link'] as String? ?? "", // Default string kosong
      detailAddress: json['detail_address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'avatar_link': avatarLink,
      'detail_address': detailAddress,
    };
  }
}

class Family {
  int? id;
  String? referral;

  Family({this.id, this.referral});

  factory Family.fromJson(Map<String, dynamic> json) {
    return Family(
      id: json['id'] as int?,
      referral: json['referral'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'referral': referral,
    };
  }
}
