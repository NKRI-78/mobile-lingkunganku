import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../../misc/api_url.dart';
import '../../misc/http_client.dart';

import '../../misc/injections.dart';
import '../../misc/pagination.dart';
import 'models/notification_count_model.dart';
import 'models/notification_model.dart';

class NotificationRepository {
  final http = getIt<BaseNetworkClient>();
  String get notif => '${MyApi.baseUrl}/api/v1/notification';

  Future<PaginationModel<NotificationModel>> getNotification(
      {int page = 1}) async {
    try {
      final res = await http.get(Uri.parse('$notif?page=$page'));

      print("Url : '$notif?page=$page'");

      final json = jsonDecode(res.body);
      print(json);

      if (res.statusCode == 200) {
        var pagination = Pagination.fromJson(json['data']);
        var list = (json['data']['data'] as List) // Ambil `data['data']`
            .map((e) => NotificationModel.fromJson(e))
            .toList();
        return PaginationModel<NotificationModel>(
            pagination: pagination, list: list);
      }

      throw json['message'] ?? "Terjadi kesalahan";
    } on SocketException {
      throw "Terjadi kesalahan jaringan";
    } catch (e) {
      rethrow;
    }
  }

  Future<NotificationCountModel> getBadgesNotif() async {
    try {
      final res = await http.get(Uri.parse('$notif/getUnreadCount'));

      debugPrint(res.body);
      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return NotificationCountModel.fromJson(json['data']);
      } else {
        throw json['message'] ?? "Terjadi kesalahan";
      }
    } on SocketException {
      throw "Terjadi kesalahan jaringan";
    }
  }

  Future<void> readNotif(String idNotif) async {
    try {
      final res = await http.post(Uri.parse('$notif/$idNotif/read'));

      debugPrint(res.body);
      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return;
      } else {
        throw json['message'] ?? "Terjadi kesalahan";
      }
    } on SocketException {
      throw "Terjadi kesalahan jaringan";
    }
  }
}
