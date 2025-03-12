import 'dart:convert';

// import 'package:json_annotation/json_annotation.dart';
// part 'pagination.g.dart';

Pagination paginationFromJson(String str) =>
    Pagination.fromJson(json.decode(str));

String paginationToJson(Pagination data) => json.encode(data.toJson());

class PaginationModel<V> {
  final Pagination pagination;
  final List<V> list;

  PaginationModel({required this.pagination, required this.list});
}

// @JsonSerializable()
class Pagination {
  int totalItems;
  int totalPages;
  int currentPage;
  int? previous;
  int? next;

  Pagination({
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.previous,
    required this.next,
  });

  static Pagination initial = Pagination(
      totalItems: 0, totalPages: 0, currentPage: 0, previous: null, next: null);

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalItems: json["total"] ?? 0,
        totalPages: json["pages"] ?? 0,
        currentPage: json["currentPage"] ?? 0,
        previous: json["previous"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "total": totalItems,
        "pages": totalPages,
        "currentPage": currentPage,
        "previous": previous,
        "next": next,
      };
}
