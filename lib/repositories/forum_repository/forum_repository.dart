import 'dart:convert';

import 'package:flutter/material.dart';
import '../../misc/api_url.dart';
import 'models/forums_model.dart';

import '../../misc/http_client.dart';
import '../../misc/injections.dart';

class ForumRepository {
  String get forums => '${MyApi.baseUrl}/api/v1/forum';

  final http = getIt<BaseNetworkClient>();

  Future<List<ForumsModel>> getForum() async {
    try {
      final res = await http.get(Uri.parse('$forums/getAllPosts'));

      print(res.body);
      print("Status : ${res.statusCode}");

      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        final list = json['data'] as List;
        return list.map((e) => ForumsModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteForum(String idForum) async {
    try {
      final res = await http.delete(Uri.parse('$forums/$idForum'));

      debugPrint('Status : ${res.body}');

      if (res.statusCode == 200) {
        return;
      } else {
        throw "error api";
      }
    } catch (e) {
      rethrow;
    }
  }
}
