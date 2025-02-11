class ProfileModel {
  int? id;
  String? username;
  String? email;
  String? phone;
  int? latitude;
  int? longitude;
  String? emailVerified;
  Null? fcmToken;
  int? balance;
  int? neighborhoodId;
  int? familyId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Neighborhood? neighborhood;
  Chief? chief;
  Null? treasurer;
  Null? secertary;
  Profile? profile;
  Family? family;
  String? roleApp;

  ProfileModel(
      {this.id,
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
      this.secertary,
      this.profile,
      this.family,
      this.roleApp});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    emailVerified = json['email_verified'];
    fcmToken = json['fcm_token'];
    balance = json['balance'];
    neighborhoodId = json['neighborhood_id'];
    familyId = json['family_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    neighborhood = json['neighborhood'] != null
        ? Neighborhood.fromJson(json['neighborhood'])
        : null;
    chief = json['chief'] != null ? Chief.fromJson(json['chief']) : null;
    treasurer = json['treasurer'];
    secertary = json['secertary'];
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    family = json['family'] != null ? Family.fromJson(json['family']) : null;
    roleApp = json['roleApp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['email_verified'] = emailVerified;
    data['fcm_token'] = fcmToken;
    data['balance'] = balance;
    data['neighborhood_id'] = neighborhoodId;
    data['family_id'] = familyId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (neighborhood != null) {
      data['neighborhood'] = neighborhood!.toJson();
    }
    if (chief != null) {
      data['chief'] = chief!.toJson();
    }
    data['treasurer'] = treasurer;
    data['secertary'] = secertary;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (family != null) {
      data['family'] = family!.toJson();
    }
    data['roleApp'] = roleApp;
    return data;
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

  Neighborhood.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    detailAddress = json['detail_address'];
    latitude = json['latitude'] != null
        ? double.tryParse(json['latitude'].toString())
        : null;
    longitude = json['longitude'] != null
        ? double.tryParse(json['longitude'].toString())
        : null;
    chiefId = json['chief_id'];
    secretaryId = json['secretary_id'];
    treasurerId = json['treasurer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['detail_address'] = detailAddress;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['chief_id'] = chiefId;
    data['secretary_id'] = secretaryId;
    data['treasurer_id'] = treasurerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Chief {
  String? referral;

  Chief({this.referral});

  Chief.fromJson(Map<String, dynamic> json) {
    referral = json['referral'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referral'] = referral;
    return data;
  }
}

class Profile {
  int? id;
  String? fullname;
  String? avatarLink;
  String? detailAddress;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.id,
      this.fullname,
      this.avatarLink,
      this.detailAddress,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    avatarLink = json['avatar_link'];
    detailAddress = json['detail_address'];
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
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
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

  Family.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    referral = json['referral'];
    neighborhoodId = json['neighborhood_id'];
    headmasterId = json['headmaster_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['referral'] = referral;
    data['neighborhood_id'] = neighborhoodId;
    data['headmaster_id'] = headmasterId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
