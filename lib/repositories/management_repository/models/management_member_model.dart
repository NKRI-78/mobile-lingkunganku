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
  String? name;
  String? detailAddress;
  double? latitude;
  double? longitude;
  String? referral;
  String? createdAt;
  List<Members>? members;
  int? totalMember;

  Data({
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
      members: json['members'] != null
          ? List<Members>.from(json['members'].map((v) => Members.fromJson(v)))
          : [],
      totalMember: json['total_member'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
  String? email;
  String? phone;
  String? createdAt;
  String? treasurer;
  String? secertary;
  Profile? profile;
  Family? family;
  String? roleApp;

  Members({
    this.email,
    this.phone,
    this.createdAt,
    this.treasurer,
    this.secertary,
    this.profile,
    this.family,
    this.roleApp,
  });

  factory Members.fromJson(Map<String, dynamic> json) {
    return Members(
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      createdAt: json['created_at'] as String?,
      treasurer: json['treasurer'] as String?,
      secertary: json['secertary'] as String?,
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      family: json['family'] != null ? Family.fromJson(json['family']) : null,
      roleApp: json['roleApp'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'created_at': createdAt,
      'treasurer': treasurer,
      'secertary': secertary,
      'profile': profile?.toJson(),
      'family': family?.toJson(),
      'roleApp': roleApp,
    };
  }
}

class Profile {
  String? fullname;
  String? avatarLink;
  String? detailAddress;

  Profile({this.fullname, this.avatarLink, this.detailAddress});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      fullname: json['fullname'] as String?,
      avatarLink: json['avatar_link'] as String?,
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
  String? referral;

  Family({this.referral});

  factory Family.fromJson(Map<String, dynamic> json) {
    return Family(
      referral: json['referral'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'referral': referral,
    };
  }
}
