import 'dart:convert';
import 'dart:io';

import 'package:mobile_lingkunganku/misc/api_url.dart';
import 'package:mobile_lingkunganku/misc/http_client.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';

class ProfileRepository {
  String get profile => '${MyApi.baseUrl}/api/v1/profile';

  final http = getIt<BaseNetworkClient>();

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
