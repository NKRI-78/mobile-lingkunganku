import 'dart:convert';

ForumsModel forumsModelFromJson(String str) =>
    ForumsModel.fromJson(json.decode(str));

String forumsModelToJson(ForumsModel data) => json.encode(data.toJson());

class ForumsModel {
  int? id;
  String? description;
  int? userId;
  int? neighborhoodId;
  double? latitude;
  double? longitude;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  User? user;
  List<ForumMedia>? forumMedia;
  List<ForumComment>? forumComment;
  List<ForumLikes>? forumLikes;
  bool? isLike;
  int? likeCount;
  int? commentCount;

  List<Media> get files =>
      forumMedia
          ?.where((e) => e.type == 'file')
          .map((e) => Media.fromJson(e.toJson()))
          .toList() ??
      [];

  ForumsModel(
      {this.id,
      this.description,
      this.userId,
      this.neighborhoodId,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.user,
      this.forumMedia,
      this.forumComment,
      this.isLike,
      this.likeCount,
      this.commentCount});

  ForumsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    userId = json['user_id'];
    neighborhoodId = json['neighborhood_id'];
    latitude = (json['latitude'] ?? 0).toDouble();
    longitude = (json['longitude'] ?? 0).toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['forum_media'] != null) {
      forumMedia = <ForumMedia>[];
      json['forum_media'].forEach((v) {
        forumMedia!.add(ForumMedia.fromJson(v));
      });
    }
    if (json['forum_comment'] != null) {
      forumComment = <ForumComment>[];
      json['forum_comment'].forEach((v) {
        forumComment!.add(ForumComment.fromJson(v));
      });
    }
    isLike = json['isLike'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['user_id'] = userId;
    data['neighborhood_id'] = neighborhoodId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (forumMedia != null) {
      data['forum_media'] = forumMedia!.map((v) => v.toJson()).toList();
    }
    if (forumComment != null) {
      data['forum_comment'] = forumComment!.map((v) => v.toJson()).toList();
    }
    data['isLike'] = isLike;
    data['likeCount'] = likeCount;
    data['commentCount'] = commentCount;
    return data;
  }
}

class ForumMedia {
  int? id;
  String? link;
  String? type;
  int? forumId;
  String? createdAt;
  String? updatedAt;

  ForumMedia(
      {this.id,
      this.link,
      this.type,
      this.forumId,
      this.createdAt,
      this.updatedAt});

  ForumMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    type = json['type'];
    forumId = json['forum_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['link'] = link;
    data['type'] = type;
    data['forum_id'] = forumId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ForumComment {
  int? id;
  String? comment;
  int? userId;
  int? forumId;
  int? commentId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  User? user;
  List<Replies>? replies;
  int? countLikes;
  int? isLike;

  ForumComment({
    this.id,
    this.comment,
    this.userId,
    this.forumId,
    this.commentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
    this.replies,
    this.countLikes,
    this.isLike,
  });

  ForumComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    userId = json['user_id'];
    forumId = json['forum_id'];
    commentId = json['comment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    countLikes = json['count_likes'];
    isLike = json['is_like'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['user_id'] = userId;
    data['forum_id'] = forumId;
    data['comment_id'] = commentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data["count_likes"] = countLikes;
    data["is_like"] = isLike;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ForumLikes {
  int? id;
  int? userId;
  int? forumId;
  String? createdAt;
  String? updatedAt;
  User? user;

  ForumLikes(
      {this.id,
      this.userId,
      this.forumId,
      this.createdAt,
      this.updatedAt,
      this.user});

  ForumLikes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    forumId = json['forum_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['forum_id'] = forumId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class ForumCommentLikes {
  int? forumCommentId;
  int? userId;

  ForumCommentLikes({this.forumCommentId, this.userId});

  ForumCommentLikes.fromJson(Map<String, dynamic> json) {
    forumCommentId = json['forum_comment_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['forum_comment_id'] = forumCommentId;
    data['user_id'] = userId;
    return data;
  }
}

class Replies {
  int? id;
  String? comment;
  int? userId;
  int? forumId;
  int? commentId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  User? user;
  List<ForumCommentLikes>? forumCommentLikes;
  int? likeCount;
  bool? isLike;

  Replies(
      {this.id,
      this.comment,
      this.userId,
      this.forumId,
      this.commentId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.user,
      this.forumCommentLikes,
      this.likeCount,
      this.isLike});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    userId = json['user_id'];
    forumId = json['forum_id'];
    commentId = json['comment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['forum_comment_likes'] != null) {
      forumCommentLikes = <ForumCommentLikes>[];
      json['forum_comment_likes'].forEach((v) {
        forumCommentLikes!.add(ForumCommentLikes.fromJson(v));
      });
    }
    likeCount = json['likeCount'];
    isLike = json['isLike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['user_id'] = userId;
    data['forum_id'] = forumId;
    data['comment_id'] = commentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (forumCommentLikes != null) {
      data['forum_comment_likes'] =
          forumCommentLikes!.map((v) => v.toJson()).toList();
    }
    data['likeCount'] = likeCount;
    data['isLike'] = isLike;
    return data;
  }
}

class User {
  String phone;
  String email;
  Profile profile;
  String username;

  User({
    required this.username,
    required this.phone,
    required this.email,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"] ?? "",
        phone: json["phone"] ?? "",
        email: json["email"] ?? "",
        profile: json["profile"] != null
            ? Profile.fromJson(json["profile"])
            : Profile.empty(),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "phone": phone,
        "email": email,
        "profile": profile.toJson(),
      };

  static User empty() => User(
        username: "",
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
  String username;

  Profile({
    required this.username,
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
        username: json["username"] ?? "",
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
        "username": username,
        "avatar_link": avatarLink,
        "detail_address": detailAddress,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  static Profile empty() => Profile(
        id: 0,
        fullname: "",
        username: "",
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
  final String link;
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
