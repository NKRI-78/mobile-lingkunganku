import 'dart:convert';

ForumsModel forumsModelFromJson(String str) =>
    ForumsModel.fromJson(json.decode(str));

String forumsModelToJson(ForumsModel data) => json.encode(data.toJson());

class ForumsModel {
  int id;
  String description;
  int userId;
  int neighborhoodId;
  double latitude;
  double longitude;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  User? user;
  List<Media> media;
  List<Comment> comment;

  ForumsModel({
    required this.id,
    required this.description,
    required this.userId,
    required this.neighborhoodId,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.user,
    required this.media,
    required this.comment,
  });

  factory ForumsModel.fromJson(Map<String, dynamic> json) => ForumsModel(
        id: json["id"] ?? 0,
        description: json["description"] ?? "",
        userId: json["user_id"] ?? 0,
        neighborhoodId: json["neighborhood_id"] ?? 0,
        latitude: (json["latitude"] ?? 0).toDouble(),
        longitude: (json["longitude"] ?? 0).toDouble(),
        createdAt:
            DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updated_at"] ?? "") ?? DateTime.now(),
        deletedAt: json["deleted_at"],
        user: json["user"] != null ? User.fromJson(json["user"]) : User.empty(),
        media: json["medias"] != null
            ? List<Media>.from(json["medias"].map((x) => Media.fromJson(x)))
            : [],
        comment: json["comments"] != null
            ? List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "user_id": userId,
        "neighborhood_id": neighborhoodId,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "user": user?.toJson(),
        "medias": List<dynamic>.from(media.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comment.map((x) => x.toJson())),
      };
}

class User {
  String phone;
  String email;
  Profile profile;

  User({
    required this.phone,
    required this.email,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        phone: json["phone"] ?? "",
        email: json["email"] ?? "",
        profile: json["profile"] != null
            ? Profile.fromJson(json["profile"])
            : Profile.empty(),
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "email": email,
        "profile": profile.toJson(),
      };

  static User empty() => User(
        phone: "",
        email: "",
        profile: Profile.empty(),
      );
}

class Profile {
  int id;
  String fullname;
  String avatarLink;
  String? detailAddress;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  Profile({
    required this.id,
    required this.fullname,
    required this.avatarLink,
    this.detailAddress,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"] ?? 0,
        fullname: json["fullname"] ?? "",
        avatarLink: json["avatar_link"] ?? "",
        detailAddress: json["detail_address"],
        userId: json["user_id"] ?? 0,
        createdAt:
            DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updated_at"] ?? "") ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "avatar_link": avatarLink,
        "detail_address": detailAddress,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  static Profile empty() => Profile(
        id: 0,
        fullname: "",
        avatarLink: "",
        detailAddress: null,
        userId: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}

class Media {
  final int id;
  final int forumId;
  final String? link;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  Media({
    required this.id,
    required this.forumId,
    required this.link,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"] ?? 0,
        forumId: json["forum_id"] ?? 0,
        link: json["link"] ?? "",
        type: json["type"] ?? "",
        createdAt:
            DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updated_at"] ?? "") ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "forum_id": forumId,
        "link": link,
        "type": type,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  static List<Media> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Media.fromJson(json)).toList();
  }
}

class Comment {
  int id;
  String comment;
  int userId;
  int forumId;
  dynamic commentId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  User? user;

  Comment(
    this.id,
    this.comment,
    this.userId,
    this.forumId,
    this.commentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
  );

  Comment.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        comment = json['comment'] ?? '',
        userId = json['user_id'] ?? 0,
        forumId = json['forum_id'] ?? 0,
        commentId = json['comment_id'],
        createdAt =
            DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
        updatedAt =
            DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
        deletedAt = json['deleted_at'],
        user = json['user'] != null ? User.fromJson(json['user']) : null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "user_id": userId,
        "forum_id": forumId,
        "comment_id": commentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "user": user,
      };
}
