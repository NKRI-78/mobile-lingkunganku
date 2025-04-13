class NewsModel {
  int? id;
  int userId;
  String linkImage;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  NewsModel({
    this.id,
    required this.userId,
    required this.linkImage,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json['id'] ?? 0,
        userId: json["user_id"] ?? 0,
        linkImage: json["link_image"] ?? "",
        title: json["title"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "link_image": linkImage,
        "title": title,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
