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
    return {
      'message': message,
      'data': data?.toJson(),
    };
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
  Family? family;
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

  MemberData({
    this.id,
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
    this.roleApp,
  });

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
    family = json['family'] != null ? Family.fromJson(json['family']) : null;
    families = json['families'] != null
        ? List<Families>.from(json['families'].map((v) => Families.fromJson(v)))
        : [];
    roleApp = json['roleApp'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'created_at': createdAt,
      'family_id': familyId,
      'updated_at': updatedAt,
      'treasurer': treasurer?.toJson(),
      'secretary': secretary?.toJson(),
      'profile': profile?.toJson(),
      'family': family?.toJson(),
      'families': families?.map((v) => v.toJson()).toList(),
      'roleApp': roleApp,
    };
  }
}

class Treasurer {
  int? id;

  Treasurer({this.id});

  Treasurer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

class Secretary {
  int? id;

  Secretary({this.id});

  Secretary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
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
    return {'id': id, 'referral': referral};
  }
}

class Families {
  String? email;
  String? phone;
  int? id;
  Chief? chief;
  Treasurer? treasurer;
  Secretary? secretary;
  ProfileFamily? profile;
  Family? family;

  Families({
    this.email,
    this.phone,
    this.id,
    this.chief,
    this.treasurer,
    this.secretary,
    this.profile,
    this.family,
  });

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
    family = json['family'] != null ? Family.fromJson(json['family']) : null;

    // Debugging
    print("Parsing Families: ID = $id, Name = ${profile?.fullname}");
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'id': id,
      'chief': chief?.toJson(),
      'treasurer': treasurer?.toJson(),
      'secretary': secretary?.toJson(),
      'profile': profile?.toJson(),
      'family': family?.toJson(),
    };
  }
}

class ProfileFamily {
  int? id;
  String? fullname;
  String? avatarLink;
  String? detailAddress;
  String? gender;
  int? userId;
  String? createdAt;
  String? updatedAt;

  ProfileFamily({
    this.id,
    this.fullname,
    this.avatarLink,
    this.detailAddress,
    this.gender,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  ProfileFamily.fromJson(Map<String, dynamic> json) {
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
    return {
      'id': id,
      'fullname': fullname,
      'avatar_link': avatarLink,
      'detail_address': detailAddress,
      'gender': gender,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
