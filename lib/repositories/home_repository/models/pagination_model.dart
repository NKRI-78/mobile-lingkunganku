// To parse this JSON data, do
//
//     final paginationModel = paginationModelFromJson(jsonString);

import 'dart:convert';

PaginationModel paginationModelFromJson(String str) =>
    PaginationModel.fromJson(json.decode(str));

String paginationModelToJson(PaginationModel data) =>
    json.encode(data.toJson());

class PaginationModel {
  final int current;
  final int totalPages;
  final int? next;

  PaginationModel({
    required this.current,
    required this.totalPages,
    this.next,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    final currentPage = json['current_page'] ?? 1;
    final pages = json['pages'] ?? 1;

    return PaginationModel(
      current: currentPage,
      totalPages: pages,
      next: currentPage < pages ? currentPage + 1 : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "currentPage": current,
        "pages": totalPages,
        "next": next,
      };
}
