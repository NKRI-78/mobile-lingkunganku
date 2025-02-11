import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/api_url.dart';
import 'package:mobile_lingkunganku/misc/http_client.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/models/management_member_model.dart';

class ManagementRepository {
  String get managementMember => '${MyApi.baseUrl}/api/v1/member';

  final http = getIt<BaseNetworkClient>();

  Future<ManagementMemberModel> getMember() async {
    try {
      final res = await http.get(Uri.parse(managementMember));

      debugPrint("📡 Response status: ${res.statusCode}");
      debugPrint("📜 Response body: ${res.body}");

      final Map<String, dynamic> json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return ManagementMemberModel.fromJson(json);
      } else {
        debugPrint("❌ Error API: ${json['message'] ?? 'Unknown error'}");
        throw Exception("API Error: ${json['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      debugPrint("❌ Exception caught: $e");
      throw Exception("Failed to fetch management members: $e");
    }
  }

  Future<Members> getMemberDetail(String userId) async {
    final res = await http.get(Uri.parse('$managementMember/$userId'));

    debugPrint("📡 Response status: ${res.statusCode}");
    debugPrint("📜 Response body: ${res.body}");

    final Map<String, dynamic> json = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return Members.fromJson(json['data']);
    } else {
      throw Exception("API Error: ${json['message'] ?? 'Unknown error'}");
    }
  }
}
