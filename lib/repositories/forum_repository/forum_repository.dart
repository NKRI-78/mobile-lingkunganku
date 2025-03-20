import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as ht;

import '../../misc/api_url.dart';
import '../../misc/http_client.dart';
import '../../misc/injections.dart';
import 'models/forum_detail_model.dart';
import 'models/forums_model.dart';

class ForumRepository {
  String get forums => '${MyApi.baseUrl}/api/v1/forum';
  String get mediaUpload => '${MyApi.baseUrlUpload}/api/v1/media';

  final http = getIt<BaseNetworkClient>();

  Future<List<ForumsModel>> getForum() async {
    try {
      final res = await http.get(Uri.parse('$forums/getAllPosts'));

      debugPrint('Response: ${res.body}');
      debugPrint("Status: ${res.statusCode}");

      if (res.statusCode == 200) {
        final jsonData = jsonDecode(res.body);
        final list = jsonData['data'] as List;
        return list.map((e) => ForumsModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getForum: $e');
      rethrow;
    }
  }

  Future<ForumDetailModel?> getDetailForum(String idForum) async {
    try {
      final res = await http.get(Uri.parse('$forums/$idForum/detail'));

      debugPrint(res.body);
      debugPrint('$forums/$idForum/detail');

      if (res.statusCode == 200) {
        final jsonData = jsonDecode(res.body);
        return ForumDetailModel.fromJson(jsonData['data']);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteForum(String idForum) async {
    try {
      final res = await http.delete(Uri.parse('$forums/$idForum'));

      debugPrint('Status: ${res.body}');

      if (res.statusCode != 200) {
        throw "Error API: ${res.body}";
      }
    } catch (e) {
      debugPrint('Error deleteForum: $e');
      rethrow;
    }
  }

  Future<void> createForum({
    String description = '',
    List<dynamic> medias = const [],
  }) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${http.token}'
      };

      var request = ht.Request('POST', Uri.parse('$forums/createPost'));
      request.body = json.encode({
        "description": description,
        "medias": medias,
      });

      debugPrint('Data Upload: ${request.body}');
      request.headers.addAll(headers);

      ht.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Forum berhasil dibuat!');
      } else {
        Map<String, dynamic> jsonData = jsonDecode(responseBody);
        String message = jsonData['message'] ?? 'Terjadi kesalahan.';
        throw Exception("Error API: $message");
      }
    } catch (e) {
      debugPrint('Error createForum: $e');
      throw Exception("Gagal membuat forum: $e");
    }
  }

  Future<List<dynamic>> postMedia({
    required String folder,
    required List<File> media,
  }) async {
    try {
      var request = ht.MultipartRequest('PUT', Uri.parse(mediaUpload));
      request.fields.addAll({'folder': folder, 'app': 'LINGKUNGANKU'});

      var headers = {'Authorization': 'Bearer ${http.token}'};
      request.headers.addAll(headers);

      for (File file in media) {
        request.files.add(await ht.MultipartFile.fromPath('files', file.path));
      }

      ht.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return jsonDecode(responseBody)['data'];
      } else {
        debugPrint('Upload failed: ${response.reasonPhrase}');
        throw 'Upload failed: ${response.reasonPhrase}';
      }
    } catch (e) {
      debugPrint('Error postMedia: $e');
      rethrow;
    }
  }

  Future<int?> createComment({
    String inputComment = '',
    String forumId = "",
    int commentId = 0,
  }) async {
    try {
      debugPrint(
          "Input : $inputComment + ForumId : $forumId + Commentid : $commentId");

      Map<String, String?> body;
      if (commentId == 0) {
        body = {
          'comment': inputComment,
          'forum_id': forumId.toString(),
        };
      } else {
        body = {
          'comment': inputComment,
          'forum_id': forumId.toString(),
          'comment_id': commentId.toString(),
        };
      }

      final res =
          await http.post(Uri.parse('$forums/createCommentPost'), body: body);

      debugPrint(res.body);

      final json = jsonDecode(res.body);
      if (res.statusCode == 201) {
        print("Fetch Id : ${json['data']['id']}");
        return json['data']['id'];
      }
      if (res.statusCode == 400) {
        throw json['message'] ?? "Terjadi kesalahan";
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setLikeUnlikeForum(String idForum) async {
    try {
      final res = await http.post(Uri.parse('$forums/$idForum/like'));

      debugPrint('Status Like  : ${res.body}');

      if (res.statusCode == 200) {
        return;
      } else {
        throw "error api";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setLikeUnlike(String commentId) async {
    try {
      final res =
          await http.post(Uri.parse('$forums/$commentId/likeComment'), body: {
        'comment_id': commentId,
      });

      debugPrint('Status Like  : ${res.body}');

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
