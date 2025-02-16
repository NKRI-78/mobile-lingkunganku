class ManagementMemberModel {
  final String message;
  final Data? data;

  ManagementMemberModel({required this.message, this.data});

  factory ManagementMemberModel.fromJson(Map<String, dynamic> json) {
    return ManagementMemberModel(
      message: json['message'] ?? 'No message',
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
  final int id;
  final String name;
  final String detailAddress;
  final double latitude;
  final double longitude;
  final String referral;
  final String createdAt;
  final List<Members> members;
  final int totalMember;

  Data({
    required this.id,
    required this.name,
    required this.detailAddress,
    required this.latitude,
    required this.longitude,
    required this.referral,
    required this.createdAt,
    required this.members,
    required this.totalMember,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      detailAddress: json['detail_address'] ?? 'No address',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      referral: json['referral'] ?? '',
      createdAt: json['created_at'] ?? '',
      members: (json['members'] as List<dynamic>?)
              ?.map((v) => Members.fromJson(v))
              .toList() ??
          [],
      totalMember: json['total_member'] ?? 0,
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
      'members': members.map((v) => v.toJson()).toList(),
      'total_member': totalMember,
    };
  }
}

class Members {
  final int id;
  final String email;
  final String phone;
  final String createdAt;
  final Treasurer? treasurer;
  final Secertary? secertary; // Mengubah secertary menjadi Secertary?
  final Profile? profile;
  final Family? family;
  final String roleApp;

  Members({
    required this.id,
    required this.email,
    required this.phone,
    required this.createdAt,
    this.treasurer,
    this.secertary,
    this.profile,
    this.family,
    required this.roleApp,
  });

  String get translateRoleApp {
    switch (roleApp.trim().toUpperCase()) {
      case 'CHIEF':
        return 'Ketua';
      case 'SECRETARY':
        return 'Sekretaris';
      case 'TRASURER':
        return 'Bendahara';
      case 'MEMBER':
        return 'Warga';
      default:
        return 'Role tidak tersedia';
    }
  }

  factory Members.fromJson(Map<String, dynamic> json) {
    return Members(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      createdAt: json['created_at'] ?? '',
      treasurer: json['treasurer'] != null
          ? Treasurer.fromJson(json['treasurer'])
          : null,
      secertary: json['secertary'] != null
          ? Secertary.fromJson(json['secertary'])
          : null,
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      family: json['family'] != null ? Family.fromJson(json['family']) : null,
      roleApp: json['roleApp'] ?? 'MEMBER',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'created_at': createdAt,
      'treasurer': treasurer?.toJson(),
      'secertary': secertary?.toJson(),
      'profile': profile?.toJson(),
      'family': family?.toJson(),
      'roleApp': roleApp,
    };
  }
}

class Treasurer {
  final int id;

  Treasurer({required this.id});

  factory Treasurer.fromJson(Map<String, dynamic> json) {
    return Treasurer(id: json['id'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

class Secertary {
  final int id;

  Secertary({required this.id});

  factory Secertary.fromJson(Map<String, dynamic> json) {
    return Secertary(id: json['id'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

class Profile {
  final String fullname;
  final String avatarLink;
  final String detailAddress;

  Profile({
    required this.fullname,
    required this.avatarLink,
    required this.detailAddress,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      fullname: json['fullname'] ?? 'Nama tidak tersedia',
      avatarLink: json['avatar_link'] ?? '',
      detailAddress: json['detail_address'] ?? 'Alamat tidak tersedia',
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
  final int id;
  final String referral;

  Family({
    required this.id,
    required this.referral,
  });

  factory Family.fromJson(Map<String, dynamic> json) {
    return Family(
      id: json['id'] ?? 0,
      referral: json['referral'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'referral': referral,
    };
  }
}
