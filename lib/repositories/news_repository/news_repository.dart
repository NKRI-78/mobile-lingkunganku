import 'dart:convert';

import 'package:flutter/material.dart';

import '../../misc/api_url.dart';
import '../../misc/http_client.dart';
import '../../misc/injections.dart';
import 'models/news_detail_model.dart';

class NewsRepository {
  String get news => '${MyApi.baseUrl}/api/v1/news';

  final http = getIt<BaseNetworkClient>();

  Future<DetailNewsModel> getDetailNews(int idNews) async {
    try {
      final res = await http.get(Uri.parse('$news/$idNews'));

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

  Future<DetailNewsModel> createNews({
    String? title,
    String? content,
    String? linkImage,
    int? userId,
    int? neighborhoodId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$news/create'),
        body: jsonEncode({
          "title": title,
          "content": content,
          "link_image": linkImage,
          "user_id": userId,
          "neighborhood_id": neighborhoodId,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${http.token}',
        },
      );

      debugPrint(response.body);
      final json = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return DetailNewsModel.fromJson(json['data']);
      } else {
        throw Exception("Gagal membuat berita, silahkan cek koneksi anda");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<DetailNewsModel> updateNews({
    required int newsId,
    String? title,
    String? content,
    String? linkImage,
    int? userId,
    int? neighborhoodId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$news/$newsId/update'),
        body: jsonEncode({
          "title": title,
          "content": content,
          "link_image": linkImage,
          "user_id": userId,
          "neighborhood_id": neighborhoodId,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${http.token}',
        },
      );

      debugPrint(response.body);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return DetailNewsModel.fromJson(json['data']);
      } else {
        throw json['message'] ?? "Failed to update news";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeNews(int newsId) async {
    try {
      final response = await http.delete(Uri.parse('$news/$newsId'));

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint(
            "Gagal menghapus berita: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint("Error saat menghapus berita: $e");
      return false;
    }
  }
}
