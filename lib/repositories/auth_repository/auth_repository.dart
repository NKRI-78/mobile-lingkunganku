import 'dart:convert';
import 'dart:io';

import '../../misc/api_url.dart';
import '../../misc/http_client.dart';
import '../../misc/injections.dart';
import 'models/city/city_model.dart';
import 'models/user/user_model.dart';

class LoggedIn {
  final User user;
  final String token;
  LoggedIn({
    required this.user,
    required this.token,
  });
}

class EmailNotActivatedFailure implements Exception {
  final String message;

  EmailNotActivatedFailure({this.message = 'Terjadi kesalahan'});
}

enum VerifyEmailType { sendingOtp, verified }

class AuthRepository {
  String get auth => '${MyApi.baseUrl}/api/v1/auth';
  String get profile => '${MyApi.baseUrl}/api/v1/profile/setAboutMe';

  final http = getIt<BaseNetworkClient>();

  Future<void> register(
    String email,
    String password,
    String username,
  ) async {
    try {
      final res = await http.post(Uri.parse('$auth/register'), body: {
        'email': email,
        'password': password,
        'name': username,
      });

      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return;
      }
      if (res.statusCode == 400) {
        throw json['message'] ?? "Terjadi kesalahan";
      }
    } on SocketException {
      throw "Terjadi kesalahan jaringan";
    }
  }

  Future<LoggedIn> login(
      {required String email, required String password}) async {
    try {
      final res = await http.post(Uri.parse(auth), body: {
        'email': email,
        'password': password,
      });

      print(res.body);
      print('Status : ${res.statusCode}');

      final json = jsonDecode(res.body);

      // print('Email Status : ${json["data"]['email_verified']}');
      if (res.statusCode == 200) {
        if (json['data']['deleted_at'] != null) {
          throw "Akun telah dihapus";
        }

        if (json["data"] != null && json["data"]['email_verified'] == null) {
          throw EmailNotActivatedFailure(
              message: json['message'] ?? "Terjadi kesalahan");
        }

        return LoggedIn(
          token: json['data']['token'],
          user: User.fromJson(
            json['data'],
          ),
        );
      }

      if (res.statusCode == 401) {
        throw EmailNotActivatedFailure(
            message: json['message'] ?? "Terjadi kesalahan");
      }
      if (res.statusCode == 400) {
        throw json['message'] ?? "Terjadi kesalahan";
      }
      if (res.statusCode == 404) {
        throw json['message'] ?? "Terjadi kesalahan";
      }
      throw json['message'] ?? "Terjadi kesalahan";
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CityModel>> getCityList() async {
    try {
      final res = await http.get(Uri.parse('$auth/getCityString'));

      print(res.body);
      print("Status : ${res.statusCode}");

      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        final list = json['data'] as List;
        return list.map((e) => CityModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setAboutMe(String gender, String age, String city) async {
    try {
      final res = await http.post(Uri.parse(profile), body: {
        'gender': gender,
        'age': age,
        'city': city,
      });

      print(res.body);
      print("Status : ${res.statusCode}");

      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return;
      }
      if (res.statusCode == 400) {
        throw json['message'] ?? "Terjadi kesalahan";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<LoggedIn?> verifyOtp(
      String email, String verificationCode, VerifyEmailType type) async {
    try {
      final res = await http.post(Uri.parse('$auth/verify-email'), body: {
        'email': email,
        'otp': verificationCode,
        'type': type == VerifyEmailType.sendingOtp ? 'SENDING_OTP' : 'VERIFIED'
      });

      print('status : ${res.body}');

      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (type == VerifyEmailType.sendingOtp) {
          return null;
        }
        return LoggedIn(
          token: json['data']['token'],
          user: User.fromJson(
            json['data'],
          ),
        );
      }
      if (res.statusCode == 400) {
        throw json['message'] ?? "Terjadi kesalahan";
      }
    } on SocketException {
      throw "Terjadi kesalahan jaringan";
    }
    return null;
  }
}
