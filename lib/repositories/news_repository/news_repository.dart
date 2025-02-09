import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/api_url.dart';
import 'package:mobile_lingkunganku/misc/http_client.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/repositories/news_repository/models/news_detail_model.dart';

class NewsRepository {
  String get newsDetail => '${MyApi.baseUrl}/api/v1/news';

  final http = getIt<BaseNetworkClient>();

  Future<DetailNewsModel> getDetailNews(int idNews) async {
    try {
      final res = await http.get(Uri.parse('$newsDetail/$idNews'));

      debugPrint(res.body);
      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return DetailNewsModel.fromJson(json);
      } else {
        throw "error api";
      }
    } catch (e) {
      rethrow;
    }
  }
}
