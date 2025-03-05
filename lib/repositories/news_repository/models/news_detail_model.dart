class DetailNewsModel {
  String? message;
  Data? data;

  DetailNewsModel({this.message, this.data});

  DetailNewsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? content;
  String? linkImage;
  int? userId;
  String? createdAt;
  String? updatedAt;
  int? neighborhoodId;

  Data({
    this.id,
    this.title,
    this.content,
    this.linkImage,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.neighborhoodId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    linkImage = json['link_image'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    neighborhoodId = json['neighborhood_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['link_image'] = linkImage;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['neighborhood_id'] = neighborhoodId;
    return data;
  }
}
