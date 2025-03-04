import 'dart:convert';

import 'forums_model.dart';

ForumDetailModel forumsModelFromJson(String str) =>
    ForumDetailModel.fromJson(json.decode(str));

String forumsModelToJson(ForumDetailModel data) => json.encode(data.toJson());

class ForumDetailModel {
  String? message;
  int? id;
  String? description;
  int? userId;
  int? neighborhoodId;
  int? latitude;
  int? longitude;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<ForumComment>? forumComment;
  User? user;
  List<ForumMedia>? forumMedia;
  List<ForumLikes>? forumLikes;
  int? likeCount;
  bool? isLike;
  int? commentCount;

  ForumDetailModel(
      {this.message,
      this.id,
      this.description,
      this.userId,
      this.neighborhoodId,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.forumComment,
      this.user,
      this.forumMedia,
      this.forumLikes,
      this.likeCount,
      this.isLike,
      this.commentCount});

  ForumDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    id = json['id'];
    description = json['description'];
    userId = json['user_id'];
    neighborhoodId = json['neighborhood_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];

    if (json['forum_comment'] != null) {
      forumComment = (json['forum_comment'] as List)
          .map((v) => ForumComment.fromJson(v))
          .toList();
    }

    user = json['user'] != null ? User.fromJson(json['user']) : null;

    if (json['forum_media'] != null) {
      forumMedia = (json['forum_media'] as List)
          .map((v) => ForumMedia.fromJson(v))
          .toList();
    }
    if (json['forum_likes'] != null) {
      forumLikes = <ForumLikes>[];
      json['forum_likes'].forEach((v) {
        forumLikes!.add(ForumLikes.fromJson(v));
      });
    }
    likeCount = json['likeCount'];
    isLike = json['isLike'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['id'] = id;
    data['description'] = description;
    data['user_id'] = userId;
    data['neighborhood_id'] = neighborhoodId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;

    if (forumComment != null) {
      data['forum_comment'] = forumComment!.map((v) => v.toJson()).toList();
    }

    if (user != null) {
      data['user'] = user!.toJson();
    }

    if (forumMedia != null) {
      data['forum_media'] = forumMedia!.map((v) => v.toJson()).toList();
    }
    if (forumLikes != null) {
      data['forum_likes'] = forumLikes!.map((v) => v.toJson()).toList();
    }
    data['likeCount'] = likeCount;
    data['isLike'] = isLike;
    data['commentCount'] = commentCount;

    return data;
  }
}

class User {
  String? phone;
  String? email;
  Profile? profile;

  User({this.phone, this.email, this.profile});

  User.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['email'] = email;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
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

  Profile({
    this.id,
    this.fullname,
    this.avatarLink,
    this.detailAddress,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

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

class ForumMedia {
  int? id;
  String? link;
  String? type;
  int? forumId;
  String? createdAt;
  String? updatedAt;

  ForumMedia({
    this.id,
    this.link,
    this.type,
    this.forumId,
    this.createdAt,
    this.updatedAt,
  });

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
