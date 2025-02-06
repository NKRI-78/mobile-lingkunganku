import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/api_url.dart';
import 'package:mobile_lingkunganku/misc/http_client.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/repositories/home_repository/models/data_pagination.dart';
import 'package:mobile_lingkunganku/repositories/home_repository/models/news_model.dart';
import 'package:mobile_lingkunganku/repositories/home_repository/models/pagination_model.dart';

class HomeRepository {
  final http = getIt<BaseNetworkClient>();

  String get news => '${MyApi.baseUrl}/api/v1/news';

  Future<DataPagination<NewsModel>> getNews({int page = 1}) async {
    try {
      final res = await http.get(Uri.parse('$news?page=$page'));

      debugPrint(res.body); // Debugging respons
      debugPrint('$news?page=$page');

      final json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        final data = json['data']; // Ambil objek data utama
        final listNews =
            (data['data'] as List?) ?? []; // Pastikan list tidak null

        return DataPagination(
          list: listNews.map((e) => NewsModel.fromJson(e)).toList(),
          paginate: data.containsKey('pagination')
              ? PaginationModel.fromJson(data['pagination'])
              : PaginationModel(
                  next: null,
                  current: 0,
                  perPage: 0), // Handle jika pagination tidak ada
        );
      } else {
        throw json['message'] ?? 'Terjadi kesalahan';
      }
    } catch (e) {
      debugPrint("Error fetching news: $e");
      rethrow;
    }
  }
}
