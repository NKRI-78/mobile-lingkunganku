import 'dart:convert';

import 'package:flutter/material.dart';

import '../../misc/api_url.dart';
import '../../misc/http_client.dart';
import '../../misc/injections.dart';
import 'models/data_pagination.dart';
import 'models/home_model.dart';
import 'models/news_model.dart';
import 'models/pagination_model.dart';

class HomeRepository {
  String get profile => '${MyApi.baseUrl}/api/v1/profile';

  String get news => '${MyApi.baseUrl}/api/v1/news';

  final http = getIt<BaseNetworkClient>();

  Future<DataPagination<NewsModel>> getNews({int page = 1}) async {
    try {
      final res = await http.get(Uri.parse('$news?page=$page'));
      debugPrint('Headers -----------0000');
      debugPrint('${res.headers}');
      debugPrint(res.body);
      debugPrint('$news?page=$page');

      final json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        final data = json['data'];
        final listNews = (data['data'] as List?) ?? [];

        return DataPagination(
          list: listNews.map((e) => NewsModel.fromJson(e)).toList(),
          paginate: data.containsKey('pagination')
              ? PaginationModel.fromJson(data['pagination'])
              : PaginationModel(next: null, current: 0, perPage: 0),
        );
      } else {
        throw json['message'] ?? 'Terjadi kesalahan';
      }
    } catch (e) {
      debugPrint("Error fetching news: $e");
      rethrow;
    }
  }

  Future<HomeModel> getProfile() async {
    try {
      final res = await http.get(Uri.parse(profile));

      debugPrint(res.body);
      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return HomeModel.fromJson(json['data']);
      } else {
        throw "error api";
      }
    } catch (e) {
      rethrow;
    }
  }
}
