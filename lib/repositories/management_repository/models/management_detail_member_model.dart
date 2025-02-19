import '../../home_repository/models/home_model.dart';

class ManagementDetailMemberModel {
  String? message;
  MemberData? data;

  ManagementDetailMemberModel({this.message, this.data});

  ManagementDetailMemberModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? MemberData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MemberData {
  int? id;
  String? email;
  String? phone;
  String? createdAt;
  int? familyId;
  String? updatedAt;
  Treasurer? treasurer;
  Secretary? secretary;
  Profile? profile;
  Treasurer? family;
  List<Families>? families;
  String? roleApp;

  String get translateRoleApp {
    switch (roleApp) {
      case 'CHIEF':
        return 'Ketua';
      case 'SECRETARY':
        return 'Sekretaris';
      case 'TREASURER':
        return 'Bendahara';
      case 'MEMBER':
        return 'Warga';
      default:
        return 'Role tidak tersedia';
    }
  }

  MemberData(
      {this.id,
      this.email,
      this.phone,
      this.createdAt,
      this.familyId,
      this.updatedAt,
      this.treasurer,
      this.secretary,
      this.profile,
      this.family,
      this.families,
      this.roleApp});

  MemberData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    createdAt = json['created_at'];
    familyId = json['family_id'];
    updatedAt = json['updated_at'];
    treasurer = json['treasurer'] != null
        ? Treasurer.fromJson(json['treasurer'])
        : null;
    secretary = json['secretary'] != null
        ? Secretary.fromJson(json['secretary'])
        : null;
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;

    family = json['family'] != null ? Treasurer.fromJson(json['family']) : null;
    if (json['families'] != null) {
      families = <Families>[];
      json['families'].forEach((v) {
        families!.add(Families.fromJson(v));
      });
    }
    roleApp = json['roleApp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['phone'] = phone;
    data['created_at'] = createdAt;
    data['family_id'] = familyId;
    data['updated_at'] = updatedAt;
    if (treasurer != null) {
      data['treasurer'] = treasurer!.toJson();
    }
    data['secretary'] = secretary;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (family != null) {
      data['family'] = family!.toJson();
    }
    if (families != null) {
      data['families'] = families!.map((v) => v.toJson()).toList();
    }
    data['roleApp'] = roleApp;
    return data;
  }
}

class Treasurer {
  int? id;

  Treasurer({this.id});

  Treasurer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class Secretary {
  int? id;

  Secretary({this.id});

  Secretary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class Profile {
  String? fullname;
  String? avatarLink;
  String? detailAddress;

  Profile({this.fullname, this.avatarLink, this.detailAddress});

  Profile.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    avatarLink = json['avatar_link'];
    detailAddress = json['detail_address'];
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

  Family.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referral = json['referral'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['referral'] = referral;
    return data;
  }
}

class Families {
  String? email;
  String? phone;
  int? id;
  Chief? chief;
  Treasurer? treasurer;
  Secretary? secretary;
  //
  ProfileFamily? profile;
  Treasurer? family;

  Families(
      {this.email,
      this.phone,
      this.id,
      this.chief,
      this.treasurer,
      this.secretary,
      this.profile,
      this.family});

  Families.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    chief = json['chief'] != null ? Chief.fromJson(json['chief']) : null;
    treasurer = json['treasurer'] != null
        ? Treasurer.fromJson(json['treasurer'])
        : null;
    secretary = json['secretary'] != null
        ? Secretary.fromJson(json['secretary'])
        : null;
    profile = json['profile'] != null
        ? ProfileFamily.fromJson(json['profile'])
        : null;
    family = json['family'] != null ? Treasurer.fromJson(json['family']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['phone'] = phone;
    data['id'] = id;
    if (chief != null) {
      data['chief'] = chief!.toJson();
    }
    data['treasurer'] = treasurer;
    data['secretary'] = secretary;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (family != null) {
      data['family'] = family!.toJson();
    }
    return data;
  }
}

class ProfileFamily {
  int? id;
  String? fullname;
  String? avatarLink;
  String? detailAddress;
  int? userId;
  String? createdAt;
  String? updatedAt;

  ProfileFamily(
      {this.id,
      this.fullname,
      this.avatarLink,
      this.detailAddress,
      this.userId,
      this.createdAt,
      this.updatedAt});

  ProfileFamily.fromJson(Map<String, dynamic> json) {
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
