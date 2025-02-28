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
    String avatarLink = '',
    String fullname = '',
    String phone = '',
  }) async {
    try {
      final response = await http.post(Uri.parse(profile), body: {
        'avatar_link': avatarLink,
        'fullname': fullname,
        'phone': phone,
      });

      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 400) {
        String errorMessage = json['message'] ?? "Terjadi kesalahan";

        // Pastikan hanya 1 kali error untuk phone already exists
        if (errorMessage.toLowerCase().contains("phone_user already")) {
          throw "Nomor telepon sudah digunakan, silakan gunakan nomor lain.";
        } else {
          throw errorMessage;
        }
      } else {
        throw "Terjadi kesalahan server (${response.statusCode})";
      }
    } on SocketException {
      throw "Terjadi kesalahan jaringan, periksa koneksi Anda.";
    } catch (e) {
      throw "Terjadi kesalahan: $e";
    }
  }
}
