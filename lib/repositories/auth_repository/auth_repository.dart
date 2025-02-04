import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../misc/api_url.dart';
import '../../misc/http_client.dart';
import '../../misc/injections.dart';
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

  final http = getIt<BaseNetworkClient>();

  Future<LoggedIn> login(
      {required String email, required String password}) async {
    try {
      final res = await http.post(Uri.parse(auth), body: {
        'email': email,
        'password': password,
      });

      debugPrint(res.body);
      final Map<String, dynamic> json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return LoggedIn(
          user: User.fromJson(
            json['data'],
          ),
          token: json['data']['token'],
        );
      }
      if (res.statusCode == 400) {
        throw json['message'] ?? "Terjadi Kesalahan";
      }
      throw json['message'] ?? "Terjadi Kesalahan";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerChief({
    String email = '',
    String password = '',
    String phone = '',
    String neighborhoodName = '',
    String detailAddress = '',
    required String latitude,
    required String longitude,
    String name = '',
  }) async {
    try {
      final response =
          await http.post(Uri.parse('$auth/register/chief'), body: {
        'email': email,
        'password': password,
        'phone': phone,
        'neighborhood_name': neighborhoodName,
        'detail_address': detailAddress,
        'latitude': latitude,
        'longitude': longitude,
        'name': name,
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

  Future<void> forgotPasswordVerifyOTP(String email, String otp) async {
    try {
      final res = await http.post(Uri.parse('$auth/forgot-password'), body: {
        'email': email,
        'step': "VERIFICATION_OTP",
        'otp': otp,
      });
      debugPrint("email : $email");
      debugPrint(res.body);

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

  Future<void> resendOtp(String email) async {
    try {
      final res = await http.post(Uri.parse('$auth/verify-email'),
          body: {'email': email, 'type': 'SENDING_OTP'});

      print("Email $email");

      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return;
      }
      if (res.statusCode == 400) {
        throw json['message'] ?? "Terjadi kesalahan";
      }
    } catch (e) {
      print(e);
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

  Future<void> forgotPasswordSendOTP(String email) async {
    try {
      final res = await http.post(Uri.parse('$auth/forgot-password'), body: {
        'email': email,
        'step': "SENDING_OTP",
      });
      debugPrint("email : $email");
      debugPrint(res.body);

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

  Future<void> forgotPasswordChangePass(
      String email, String otp, String password) async {
    try {
      final res = await http.post(Uri.parse('$auth/forgot-password'), body: {
        'email': email,
        'step': "CHANGE_PASSWORD",
        'otp': otp,
        'password': password,
      });
      debugPrint("email : $email");
      debugPrint(res.body);

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
}
