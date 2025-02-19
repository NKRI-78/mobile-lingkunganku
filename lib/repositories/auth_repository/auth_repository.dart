import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as httpupload;

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
  EmailNotActivatedFailure({this.message = 'Akun belum diverifikasi.'});
}

class EmailNotFoundFailure implements Exception {
  final String message;
  EmailNotFoundFailure({this.message = 'Email tidak ditemukan.'});
}

enum VerifyEmailType { sendingOtp, verified }

class AuthRepository {
  String get auth => '${MyApi.baseUrl}/api/v1/auth';
  String get mediaUpload => '${MyApi.baseUrlUpload}/api/v1/media';

  final http = getIt<BaseNetworkClient>();

  Future<List<dynamic>> postMedia(
      {required String folder, required File media}) async {
    try {
      var request = httpupload.MultipartRequest('PUT', Uri.parse(mediaUpload));
      request.fields.addAll({'folder': 'profile', 'app': 'LINGKUNGANKU'});
      var headers = {'Authorization': 'Bearer ${http.token}'};
      request.headers.addAll(headers);
      debugPrint("Image : $media");
      request.files
          .add(await httpupload.MultipartFile.fromPath('images', media.path));

      httpupload.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();
        return jsonDecode(data)['data'];
      } else {
        debugPrint(response.reasonPhrase);
      }
      return [];
    } catch (e) {
      debugPrint('error profile $e');
      rethrow;
    }
  }

  Future<LoggedIn> login(
      {required String email, required String password}) async {
    try {
      final res = await http.post(Uri.parse(auth), body: {
        'email': email,
        'password': password,
      });

      debugPrint(res.body);
      final json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        if (json['data']['deleted_at'] != null) {
          throw "Akun telah dihapus";
        }

        if (json["data"] != null && json["data"]['email_verified'] == null) {
          throw EmailNotActivatedFailure(
              message: json['message'] ?? "Terjadi kesalahan");
        }
        return LoggedIn(
          user: User.fromJson(
            json['data'],
          ),
          token: json['data']['token'],
        );
      }
      if (res.statusCode == 400) {
        if (json['error'] != null &&
            json['error']['message'] == "Email tidak ditemukan") {
          throw EmailNotFoundFailure();
        }

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
    String avatarLink = '',
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
        'avatar_link': avatarLink,
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

  Future<void> registerMember({
    String name = '',
    String email = '',
    String phone = '',
    String detailAddress = '',
    String password = '',
    String referral = '',
    String avatarLink = '',
  }) async {
    try {
      final response =
          await http.post(Uri.parse('$auth/register/member'), body: {
        'name': name,
        'email': email,
        'phone': phone,
        'detail_address': detailAddress,
        'password': password,
        'referral': referral,
        'avatar_link': avatarLink,
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
