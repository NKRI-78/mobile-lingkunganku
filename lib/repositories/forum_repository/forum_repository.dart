import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../../misc/api_url.dart';
import 'models/forums_model.dart';
import 'package:http/http.dart' as ht;

import '../../misc/http_client.dart';
import '../../misc/injections.dart';

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

      if (response.statusCode == 200) {
        debugPrint('Success: $responseBody');
      } else {
        Map<String, dynamic> jsonData = jsonDecode(responseBody);
        String message = jsonData['message'] ?? 'Unknown error';
        debugPrint('Error: $message');
        throw message;
      }
    } catch (e) {
      debugPrint('Error createForum: $e');
      rethrow;
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
}
