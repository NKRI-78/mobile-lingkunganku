import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:mobile_lingkunganku/misc/api_url.dart';
import 'package:mobile_lingkunganku/misc/http_client.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/repositories/event_repository/models/event_model.dart';

import 'models/event_detail_model.dart';

class EventRepository {
  String get event => '${MyApi.baseUrl}/api/v1/event';

  final http = getIt<BaseNetworkClient>();

  Future<List<EventModel>> getEvents() async {
    try {
      final res = await http.get(Uri.parse(event));

      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        final list = json['data']['data'] as List;
        return list.map((e) => EventModel.fromJson(e)).toList();
      } else {
        throw "error api";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<EventModel> createEvent({
    required String title,
    required String description,
    String? startTime,
    String? endTime,
    String? address,
    required DateTime startDate,
    required DateTime endDate,
    int? neighborhoodId,
    int? userId,
    String? imageUrl,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(event),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title,
          'description': description,
          'start': startTime,
          'end': endTime,
          'address': address,
          'start_date': startDate.toIso8601String(),
          'end_date': endDate.toIso8601String(),
          'neighborhood_id': neighborhoodId,
          'user_id': userId,
          'image_url': imageUrl,
        }),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return EventModel.fromJson(json['data']);
      } else {
        throw json['message']?.toString() ??
            "Terjadi kesalahan saat membuat event";
      }
    } on SocketException {
      throw "Terjadi kesalahan jaringan. Periksa koneksi internet Anda.";
    } catch (e) {
      throw "Error: $e";
    }
  }

  Future<EventDetailModel> getEventDetail(int idEvent) async {
    try {
      final res = await http.get(Uri.parse('$event/$idEvent/detail'));

      debugPrint(res.body);
      final json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return EventDetailModel.fromJson(json);
      } else {
        throw "error api";
      }
    } catch (e) {
      rethrow;
    }
  }
}
