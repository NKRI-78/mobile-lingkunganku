class User {
  int? id;
  String? username;
  String? email;
  String? phone;
  int? latitude;
  int? longitude;
  String? otp;
  String? emailVerified;
  String? fcmToken;
  int? balance;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Profile? profile;
  bool? authorized;
  String? token;
  String? refreshToken;

  User(
      {this.id,
      this.username,
      this.email,
      this.phone,
      this.latitude,
      this.longitude,
      this.otp,
      this.emailVerified,
      this.fcmToken,
      this.balance,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.profile,
      this.authorized,
      this.token,
      this.refreshToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    otp = json['otp'];
    emailVerified = json['email_verified'];
    fcmToken = json['fcm_token'];
    balance = json['balance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    authorized = json['authorized'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['otp'] = otp;
    data['email_verified'] = emailVerified;
    data['fcm_token'] = fcmToken;
    data['balance'] = balance;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    data['authorized'] = authorized;
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    return data;
  }

  User copyWith({Profile? profile}) {
    return User(
        id: id,
        username: username,
        latitude: latitude,
        longitude: longitude,
        emailVerified: emailVerified,
        createdAt: createdAt,
        updatedAt: updatedAt,
        email: email,
        token: token,
        profile: profile ?? this.profile);
  }
}

class Profile {
  int? id;
  String? fullname;
  String? birthOfDate;
  String? linkAvatar;
  String? gender;
  String? city;
  String? linkBanner;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.id,
      this.fullname,
      this.birthOfDate,
      this.linkAvatar,
      this.gender,
      this.city,
      this.linkBanner,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    birthOfDate = json['birth_of_date'];
    linkAvatar = json['link_avatar'];
    gender = json['gender'];
    city = json['city'];
    linkBanner = json['link_banner'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['birth_of_date'] = birthOfDate;
    data['link_avatar'] = linkAvatar;
    data['gender'] = gender;
    data['city'] = city;
    data['link_banner'] = linkBanner;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
