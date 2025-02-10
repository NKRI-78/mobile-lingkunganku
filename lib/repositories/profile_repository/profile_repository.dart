import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import '../../misc/api_url.dart';
import '../../misc/http_client.dart';
import '../../misc/injections.dart';
import 'models/profile_model.dart';

class ProfileRepository {
  String get profile => '${MyApi.baseUrl}/api/v1/profile';

  final http = getIt<BaseNetworkClient>();

  Future<ProfileModel> getProfile() async {
    try {
      final res = await http.get(Uri.parse(profile));

      debugPrint(res.body);
      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return ProfileModel.fromJson(json['data']);
      } else {
        throw "error api";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProfile({
    String linkAvatar = '',
    String fullname = '',
    String phone = '',
  }) async {
    try {
      final response = await http.post(Uri.parse(profile), body: {
        'avatar_link': linkAvatar,
        'fullname': fullname,
        'phone': phone,
      });
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return;
      }
      if (response.statusCode == 400) {
        throw json['message'] ?? "Terjadi kesalahan";
      }
    } on SocketException {
      throw "Terjadi kesalahan jaringan";
    }
  }
}
