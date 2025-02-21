import 'dart:convert';
import 'package:flutter/material.dart';
import '../../misc/api_url.dart';
import '../../misc/http_client.dart';
import '../../misc/injections.dart';
import 'models/management_detail_member_model.dart';
import 'models/management_member_model.dart';

class ManagementRepository {
  String get managementMember => '${MyApi.baseUrl}/api/v1/member';

  final http = getIt<BaseNetworkClient>();

  Future<ManagementMemberModel> getMember() async {
    try {
      final res = await http.get(Uri.parse(managementMember));

      debugPrint(" Response status: ${res.statusCode}");
      debugPrint(" Response body: ${res.body}");

      final Map<String, dynamic> json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return ManagementMemberModel.fromJson(json);
      } else {
        debugPrint(" Error API: ${json['message'] ?? 'Unknown error'}");
        throw Exception("API Error: ${json['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      debugPrint(" Exception caught: $e");
      throw Exception("Failed to fetch management members: $e");
    }
  }

  Future<ManagementDetailMemberModel> getMemberDetail(String userId) async {
    final res = await http.get(Uri.parse('$managementMember/$userId'));

    debugPrint(" Response status: ${res.statusCode}");
    debugPrint(" Response body: ${res.body}");

    final Map<String, dynamic> json = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return ManagementDetailMemberModel.fromJson(json);
    } else {
      throw Exception("API Error: ${json['message'] ?? 'Unknown error'}");
    }
  }

  Future<ManagementDetailMemberModel> postMemberSecretary(String userId) async {
    try {
      final res = await http.post(
        Uri.parse('$managementMember/$userId/giveRoleSecretary'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${http.token}',
        },
        body: jsonEncode({"roleApp": "SECRETARY"}),
      );

      debugPrint(" Response status: ${res.statusCode}");
      debugPrint(" Response body: ${res.body}");

      if (res.statusCode == 200) {
        debugPrint(" Role berhasil diubah menjadi SECRETARY");

        // 🔹 Ambil data terbaru setelah role berubah
        return await getMemberDetail(userId);
      } else {
        final Map<String, dynamic> json = jsonDecode(res.body);
        debugPrint(" API Error: ${json['message'] ?? 'Unknown error'}");
        throw Exception("API Error: ${json['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      debugPrint(" Exception caught: $e");
      throw Exception("Failed to update member role: $e");
    }
  }

  Future<ManagementDetailMemberModel> postMemberTreasure(String userId) async {
    try {
      final res = await http.post(
        Uri.parse('$managementMember/$userId/giveRoleTreasure'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${http.token}',
        },
        body: jsonEncode({"roleApp": "TREASURER"}),
      );

      debugPrint(" Response status: ${res.statusCode}");
      debugPrint(" Response body: ${res.body}");

      if (res.statusCode == 200) {
        debugPrint(" Role berhasil diubah menjadi TREASURER");

        // 🔹 Ambil data terbaru setelah role berubah
        return await getMemberDetail(userId);
      } else {
        final Map<String, dynamic> json = jsonDecode(res.body);
        debugPrint(" API Error: ${json['message'] ?? 'Unknown error'}");
        throw Exception("API Error: ${json['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      debugPrint(" Exception caught: ${jsonEncode(e)}");
      rethrow;
    }
  }

  Future<ManagementDetailMemberModel> postChief(String userId) async {
    try {
      final res = await http.post(
        Uri.parse('$managementMember/$userId/giveRoleChief'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${http.token}',
        },
        body: jsonEncode({"roleApp": "CHIEF"}),
      );

      debugPrint(" Response status: ${res.statusCode}");
      debugPrint(" Response body: ${res.body}");

      if (res.statusCode == 200) {
        debugPrint(" Role berhasil diubah menjadi CHIEF");

        // 🔹 Ambil data terbaru setelah role berubah
        return await getMemberDetail(userId);
      } else {
        final Map<String, dynamic> json = jsonDecode(res.body);
        debugPrint(" API Error: ${json['message'] ?? 'Unknown error'}");
        throw Exception("API Error: ${json['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      debugPrint(" Exception caught: ${jsonEncode(e)}");
      rethrow;
    }
  }

  Future<bool> removeMember(String userId) async {
    try {
      final response = await http.post(
        Uri.parse('$managementMember/$userId/removeMember'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return json["success"] ?? false;
      } else {
        throw Exception("Gagal menghapus anggota: ${response.body}");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan saat menghapus anggota.");
    }
  }
}
