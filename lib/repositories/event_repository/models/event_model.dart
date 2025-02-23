class EventModel {
  final int id;
  final int userId;
  final int neighborhoodId;
  final String title;
  final String imageUrl;
  final String description;
  final String start;
  final String end;
  final String address;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel user;
  final List<UserJoinModel> userJoins;
  final bool isJoin;
  final bool isExpired;

  EventModel({
    required this.id,
    required this.userId,
    required this.neighborhoodId,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.start,
    required this.end,
    required this.address,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.userJoins,
    required this.isJoin,
    required this.isExpired,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      userId: json['user_id'] is int
          ? json['user_id']
          : int.tryParse(json['user_id'].toString()) ?? 0,
      neighborhoodId: json['neighborhood_id'] is int
          ? json['neighborhood_id']
          : int.tryParse(json['neighborhood_id'].toString()) ?? 0,
      title: json['title'] ?? '',
      imageUrl: json['image_url'] ?? '',
      description: json['description'] ?? '',
      start: json['start'] ?? '',
      end: json['end'] ?? '',
      address: json['address'] ?? '',
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : DateTime.now(),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : DateTime.now(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      user: UserModel.fromJson(json['user'] ?? {}),
      userJoins: (json['user_joins'] as List<dynamic>? ?? [])
          .map((e) => UserJoinModel.fromJson(e ?? {}))
          .toList(),
      isJoin: json['isJoin'] ?? false,
      isExpired: json['isExpired'] ?? false,
    );
  }
}

class UserModel {
  final int id;
  final String email;
  final String phone;
  // final ProfileModel profile;

  UserModel({
    required this.id,
    required this.email,
    required this.phone,
    // required this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      // profile: ProfileModel.fromJson(json['profile'] ?? {}),
    );
  }
}

// class ProfileModel {
//   final int id;
//   final String fullname;
//   final String avatarLink;
//   final String? detailAddress;

//   ProfileModel({
//     required this.id,
//     required this.fullname,
//     required this.avatarLink,
//     this.detailAddress,
//   });

//   factory ProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfileModel(
//       id: json['id'] is int
//           ? json['id']
//           : int.tryParse(json['id'].toString()) ?? 0,
//       fullname: json['fullname'] ?? '',
//       avatarLink: json['avatar_link'] ?? '',
//       detailAddress: json['detail_address'],
//     );
//   }
// }

class UserJoinModel {
  final int id;
  final int userId;
  final int eventId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel user;

  UserJoinModel({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory UserJoinModel.fromJson(Map<String, dynamic> json) {
    return UserJoinModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      userId: json['user_id'] is int
          ? json['user_id']
          : int.tryParse(json['user_id'].toString()) ?? 0,
      eventId: json['event_id'] is int
          ? json['event_id']
          : int.tryParse(json['event_id'].toString()) ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }
}
