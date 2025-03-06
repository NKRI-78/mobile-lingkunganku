import 'dart:convert';
import 'dart:io';

import 'package:mobile_lingkunganku/misc/api_url.dart';
import 'package:mobile_lingkunganku/misc/http_client.dart';

import '../../misc/injections.dart';
import '../../misc/pagination.dart';
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
        var list = (json['data']['data'] as List)
            .map((e) => NotificationModel.fromJson(e))
            .toList();
        print("Url : ${jsonEncode(pagination)}");
        return PaginationModel<NotificationModel>(
            pagination: pagination, list: list);
      }
      if (res.statusCode == 400) {
        throw json['message'] ?? "Terjadi kesalahan";
      } else {
        throw "Error";
      }
    } on SocketException {
      throw "Terjadi kesalahan jaringan";
    } catch (e) {
      rethrow;
    }
  }
}
