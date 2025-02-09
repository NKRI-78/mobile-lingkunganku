// To parse this JSON data, do
//
//     final detailNewsModel = detailNewsModelFromJson(jsonString);

import 'dart:convert';

DetailNewsModel detailNewsModelFromJson(String str) =>
    DetailNewsModel.fromJson(json.decode(str));

String detailNewsModelToJson(DetailNewsModel data) =>
    json.encode(data.toJson());

class DetailNewsModel {
  String message;
  Data data;

  DetailNewsModel({
    required this.message,
    required this.data,
  });

  factory DetailNewsModel.fromJson(Map<String, dynamic> json) =>
      DetailNewsModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String userId;
  String imageUrl;
  String title;
  String description;
  String link;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Data({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        imageUrl: json["image_url"],
        title: json["title"],
        description: json["description"],
        link: json["link"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "image_url": imageUrl,
        "title": title,
        "description": description,
        "link": link,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
