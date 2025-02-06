// To parse this JSON data, do
//
//     final paginationModel = paginationModelFromJson(jsonString);

import 'dart:convert';

PaginationModel paginationModelFromJson(String str) =>
    PaginationModel.fromJson(json.decode(str));

String paginationModelToJson(PaginationModel data) =>
    json.encode(data.toJson());

class PaginationModel {
  int current;
  int perPage;
  int? previous;
  int? next;

  PaginationModel({
    required this.current,
    required this.perPage,
    this.previous,
    this.next,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
        current: json["current"],
        perPage: json["perPage"],
        previous: json["previous"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "current": current,
        "perPage": perPage,
        "previous": previous,
        "next": next,
      };
}
