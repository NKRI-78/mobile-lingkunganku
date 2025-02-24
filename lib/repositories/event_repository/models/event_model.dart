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
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      userId: int.tryParse(json['user_id']?.toString() ?? '') ?? 0,
      neighborhoodId:
          int.tryParse(json['neighborhood_id']?.toString() ?? '') ?? 0,
      title: json['title']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      start: json['start']?.toString() ?? '',
      end: json['end']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      startDate: json['start_date'] != null
          ? DateTime.tryParse(json['start_date'].toString()) ?? DateTime.now()
          : DateTime.now(),
      endDate: json['end_date'] != null
          ? DateTime.tryParse(json['end_date'].toString()) ?? DateTime.now()
          : DateTime.now(),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      user: UserModel.fromJson(json['user'] ?? {}),
      userJoins: (json['user_joins'] as List<dynamic>?)
              ?.map((e) => UserJoinModel.fromJson(e))
              .toList() ??
          [],
      isJoin: json['isJoin'] as bool? ?? false,
      isExpired: json['isExpired'] as bool? ?? false,
    );
  }
}

class UserModel {
  final int id;
  final String email;
  final String phone;
  // final ProfileModel? profile;

  UserModel({
    required this.id,
    required this.email,
    required this.phone,
    // this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      // profile: json['profile'] != null ? ProfileModel.fromJson(json['profile']) : null,
    );
  }
}

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
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      userId: int.tryParse(json['user_id']?.toString() ?? '') ?? 0,
      eventId: int.tryParse(json['event_id']?.toString() ?? '') ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }
}
