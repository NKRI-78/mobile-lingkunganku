import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../misc/api_url.dart';
import '../../misc/http_client.dart';
import '../../misc/injections.dart';

class SosRepository {
  String get sos => '${MyApi.baseUrl}/api/v1/sos';

  final http = getIt<BaseNetworkClient>();

  Future<void> sendSos({
    String latitude = "",
    String longitude = "",
    String title = "",
    String message = "",
  }) async {
    try {
      Map<String, String?> body;
      body = {
        'latitude': latitude,
        'longitude': longitude,
        'title': title,
        'message': message,
      };
      final res = await http.post(Uri.parse(sos), body: body);

      debugPrint("Data sos $body");
      debugPrint(res.body);

      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return;
      }
      if (res.statusCode == 400) {
        throw json['message'] ?? "Terjadi kesalahan";
      }
    } on SocketException {
      throw "Terjadi Kesalahan Jaringan";
    } on TimeoutException {
      throw "Koneksi internet lambat, periksa jaringan Anda";
    } catch (e) {
      rethrow;
    }
  }
}
