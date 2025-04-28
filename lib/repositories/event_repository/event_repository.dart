import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import '../../misc/api_url.dart';
import '../../misc/http_client.dart';
import '../../misc/injections.dart';
import 'models/event_model.dart';

import 'models/event_detail_model.dart';

class EventRepository {
  String get event => '${MyApi.baseUrl}/api/v1/event';

  final http = getIt<BaseNetworkClient>();

  Future<List<EventModel>> getEvents() async {
    try {
      debugPrint("Fetching events...");

      final res =
          await http.get(Uri.parse(event)).timeout(Duration(seconds: 30));

      debugPrint("Response Status: ${res.statusCode}");
      debugPrint("Response Body: ${res.body}");

      if (res.statusCode >= 200 && res.statusCode < 300) {
        if (res.body.isNotEmpty) {
          final json = jsonDecode(res.body);
          final list = json['data']['data'] as List;
          return list.map((e) => EventModel.fromJson(e)).toList();
        } else {
          throw "Empty response body";
        }
      } else {
        throw "Error API: ${res.statusCode} - ${res.body}";
      }
    } on SocketException {
      throw "Terjadi Kesalahan Jaringan";
    } on TimeoutException {
      throw "Koneksi internet lambat, periksa jaringan Anda";
    } catch (e) {
      debugPrint("Error fetching events: $e");
      rethrow;
    }
  }

  Future<EventModel> createEvent({
    required String title,
    required String description,
    required String startTime,
    required String endTime,
    String? address,
    required String startDate,
    required String endDate,
    int? neighborhoodId,
    int? userId,
    String? imageUrl,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(event),
        body: jsonEncode({
          'title': title,
          'description': description,
          'start': startTime,
          'end': endTime,
          'address': address,
          'startDate': startDate,
          'endDate': endDate,
          'neighborhood_id': neighborhoodId,
          'user_id': userId,
          'image_url': imageUrl,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${http.token}',
        },
      );
      debugPrint(response.body);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return EventModel.fromJson(json['data']);
      } else {
        throw Exception(json['message'] ?? 'Terjadi kesalahan');
      }
    } on SocketException {
      throw "Terjadi Kesalahan Jaringan";
    } on TimeoutException {
      throw "Koneksi internet lambat, periksa jaringan Anda";
    } catch (e) {
      rethrow;
    }
  }

  Future<EventDetailModel> getEventDetail(int idEvent) async {
    try {
      final res = await http.get(Uri.parse('$event/$idEvent/detail'));

      debugPrint("API RESPONSE: ${res.body}");
      final json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return EventDetailModel.fromJson(json);
      } else {
        throw "Error API: ${res.statusCode} - ${res.body}";
      }
    } on SocketException {
      throw "Terjadi Kesalahan Jaringan";
    } on TimeoutException {
      throw "Koneksi internet lambat, periksa jaringan Anda";
    } catch (e) {
      debugPrint("Error fetching event: $e");
      rethrow;
    }
  }

  Future<bool> removeEvent(int idEvent) async {
    try {
      final response = await http.delete(Uri.parse('$event/$idEvent/delete'));

      if (response.statusCode == 200) {
        return true;
      } else {
        print(
            "Gagal menghapus event: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error saat menghapus event: $e");
      return false;
    }
  }
}
