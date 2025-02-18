import '../../../modules/profile/models/families_model.dart';

class ProfileModel {
  String? avatarLink;
  int? id;
  String? username;
  String? email;
  String? phone;
  double? latitude;
  double? longitude;
  String? emailVerified;
  dynamic fcmToken;
  int? balance;
  int? neighborhoodId;
  int? familyId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Neighborhood? neighborhood;
  Chief? chief;
  dynamic treasurer;
  dynamic secretary;
  Profile? profile;
  Family? family;
  String? roleApp;
  final List<FamiliesModel> families;

  ProfileModel({
    this.avatarLink,
    this.id,
    this.username,
    this.email,
    this.phone,
    this.latitude,
    this.longitude,
    this.emailVerified,
    this.fcmToken,
    this.balance,
    this.neighborhoodId,
    this.familyId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.neighborhood,
    this.chief,
    this.treasurer,
    this.secretary,
    this.profile,
    this.family,
    this.roleApp,
    required this.families,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      avatarLink: json['avatar_link'],
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      emailVerified: json['email_verified'],
      fcmToken: json['fcm_token'],
      balance: json['balance'],
      neighborhoodId: json['neighborhood_id'],
      familyId: json['family_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      neighborhood: json['neighborhood'] != null
          ? Neighborhood.fromJson(json['neighborhood'])
          : null,
      chief: json['chief'] != null ? Chief.fromJson(json['chief']) : null,
      treasurer: json['treasurer'],
      secretary: json['secretary'],
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      family: json['family'] != null ? Family.fromJson(json['family']) : null,
      roleApp: json['roleApp'],
      families:
          (json['families'] as List?) // ✅ Pastikan parsing list dengan benar
                  ?.map((item) => FamiliesModel.fromJson(item))
                  .toList() ??
              [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar_link': avatarLink,
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'email_verified': emailVerified,
      'fcm_token': fcmToken,
      'balance': balance,
      'neighborhood_id': neighborhoodId,
      'family_id': familyId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'neighborhood': neighborhood?.toJson(),
      'chief': chief?.toJson(),
      'treasurer': treasurer,
      'secretary': secretary,
      'profile': profile?.toJson(),
      'family': family?.toJson(),
      'roleApp': roleApp,
    };
  }
}

class Neighborhood {
  int? id;
  String? name;
  String? detailAddress;
  double? latitude;
  double? longitude;
  int? chiefId;
  int? secretaryId;
  int? treasurerId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Neighborhood({
    this.id,
    this.name,
    this.detailAddress,
    this.latitude,
    this.longitude,
    this.chiefId,
    this.secretaryId,
    this.treasurerId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Neighborhood.fromJson(Map<String, dynamic> json) {
    return Neighborhood(
      id: json['id'],
      name: json['name'],
      detailAddress: json['detail_address'],
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      chiefId: json['chief_id'],
      secretaryId: json['secretary_id'],
      treasurerId: json['treasurer_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'detail_address': detailAddress,
      'latitude': latitude,
      'longitude': longitude,
      'chief_id': chiefId,
      'secretary_id': secretaryId,
      'treasurer_id': treasurerId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

class Chief {
  String? referral;

  Chief({this.referral});

  factory Chief.fromJson(Map<String, dynamic> json) {
    return Chief(
      referral: json['referral'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'referral': referral};
  }
}

class Profile {
  int? id;
  String? username;
  String? fullname;
  // String? phone;
  String? avatarLink;
  String? detailAddress;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Profile({
    this.id,
    this.username,
    this.fullname,
    // this.phone,
    this.avatarLink,
    this.detailAddress,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      username: json['username'],
      fullname: json['fullname'],
      // phone: json['phone'],
      avatarLink: json['avatar_link'],
      detailAddress: json['detail_address'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'fullname': fullname,
      // 'phone': phone,
      'avatar_link': avatarLink,
      'detail_address': detailAddress,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Family {
  int? id;
  String? name;
  String? referral;
  int? neighborhoodId;
  int? headmasterId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Family({
    this.id,
    this.name,
    this.referral,
    this.neighborhoodId,
    this.headmasterId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Family.fromJson(Map<String, dynamic> json) {
    return Family(
      id: json['id'],
      name: json['name'],
      referral: json['referral'],
      neighborhoodId: json['neighborhood_id'],
      headmasterId: json['headmaster_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'referral': referral,
      'neighborhood_id': neighborhoodId,
      'headmaster_id': headmasterId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
