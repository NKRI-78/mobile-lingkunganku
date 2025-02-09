class HomeModel {
  String? message;
  Data? data;

  HomeModel({this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.toJson(),
      };
}

class Data {
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
  dynamic deletedAt;
  Neighborhood? neighborhood;
  Chief? chief;
  dynamic treasurer;
  dynamic secretary;
  Profile? profile;
  Family? family;
  String? roleApp;

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        phone = json['phone'],
        latitude = (json['latitude'] as num?)?.toDouble(),
        longitude = (json['longitude'] as num?)?.toDouble(),
        emailVerified = json['email_verified'],
        fcmToken = json['fcm_token'],
        balance = json['balance'],
        neighborhoodId = json['neighborhood_id'],
        familyId = json['family_id'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'],
        neighborhood = json['neighborhood'] != null
            ? Neighborhood.fromJson(json['neighborhood'])
            : null,
        chief = json['chief'] != null ? Chief.fromJson(json['chief']) : null,
        treasurer = json['treasurer'],
        secretary = json['secretary'],
        profile =
            json['profile'] != null ? Profile.fromJson(json['profile']) : null,
        family =
            json['family'] != null ? Family.fromJson(json['family']) : null,
        roleApp = json['roleApp'];

  Map<String, dynamic> toJson() => {
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

class Neighborhood {
  int? id;
  dynamic name;
  String? detailAddress;
  double? latitude;
  double? longitude;
  int? chiefId;
  dynamic secretaryId;
  dynamic treasurerId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Neighborhood.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        detailAddress = json['detail_address'],
        latitude = (json['latitude'] as num?)?.toDouble(),
        longitude = (json['longitude'] as num?)?.toDouble(),
        chiefId = json['chief_id'],
        secretaryId = json['secretary_id'],
        treasurerId = json['treasurer_id'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];

  Map<String, dynamic> toJson() => {
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

class Chief {
  String? referral;

  Chief.fromJson(Map<String, dynamic> json) : referral = json['referral'];

  Map<String, dynamic> toJson() => {
        'referral': referral,
      };
}

class Profile {
  int? id;
  String? fullname;
  String? avatarLink;
  dynamic detailAddress;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Profile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fullname = json['fullname'],
        avatarLink = json['avatar_link'],
        detailAddress = json['detail_address'],
        userId = json['user_id'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

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

class Family {
  int? id;
  dynamic name;
  String? referral;
  int? neighborhoodId;
  int? headmasterId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Family.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        referral = json['referral'],
        neighborhoodId = json['neighborhood_id'],
        headmasterId = json['headmaster_id'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];

  Map<String, dynamic> toJson() => {
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
