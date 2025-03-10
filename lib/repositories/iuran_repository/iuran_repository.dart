import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../../misc/api_url.dart';
import '../../misc/http_client.dart';
import '../../misc/injections.dart';
import 'models/iuran_model.dart';

class IuranRepository {
  String get iuran => '${MyApi.baseUrl}/api/v1/invoice';

  final http = getIt<BaseNetworkClient>();

  Future<void> createInvoice({
    required int userId,
    required int amount,
    required String description,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$iuran/createInvoicePerAccount'),
        body: {
          'amount': amount.toString(),
          'description': description,
          'user_id': userId.toString(),
        },
      );

      final json = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw json['message'] ?? "Gagal membuat iuran";
      }
    } on SocketException {
      throw "Terjadi kesalahan jaringan";
    }
  }

  Future<bool> hasUnpaidInvoice(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$iuran/getUnpaidInvoices'),
      );

      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List invoices = json['data'];

        return invoices.any((invoice) =>
            invoice['user_id'] == userId && invoice['status'] == "unpaid");
      } else {
        throw json['message'] ?? "Gagal mengecek invoice";
      }
    } on SocketException {
      throw "Terjadi kesalahan jaringan";
    }
  }

  Future<IuranModel> getInvoice() async {
    try {
      final res = await http.get(
        Uri.parse('$iuran/getUnpaidInvoices'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${http.token}',
        },
      );

      if (res.statusCode == 200) {
        debugPrint("Invoice berhasil dilihat");
        final jsonResponse = jsonDecode(res.body);
        return IuranModel.fromJson(
            jsonResponse); // Hanya satu model, bukan list
      } else {
        throw Exception("Failed to load invoice: ${res.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception caught: $e");
      throw Exception("Terjadi kesalahan: $e");
    }
  }
}
