import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/repositories/iuran_repository/models/iuran_count_model.dart';
import 'models/iuran_paid_model.dart';
import '../../misc/api_url.dart';
import '../../misc/http_client.dart';
import '../../misc/injections.dart';
import '../../modules/app/bloc/app_bloc.dart';
import 'models/iuran_model.dart';
import 'models/payment_channel_model.dart';
import 'package:http/http.dart' as httpBase;

class IuranRepository {
  String get iuran => '${MyApi.baseUrl}/api/v1/invoice';
  String get paymentChannel => '${MyApi.baseUrl}/api/v1/payment/channel';
  String get checkoutItems => '${MyApi.baseUrl}/api/v1/invoice/createPayment';

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
      throw "Terjadi Kesalahan Jaringan";
    } on TimeoutException {
      throw "Koneksi internet lambat, periksa jaringan Anda";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateInvoice({
    required int userId,
    required int amount,
    required String description,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$iuran/updateInvoicePerAccount'),
        body: {
          'amount': amount.toString(),
          'description': description,
          'user_id': userId.toString(),
        },
      );

      final json = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw json['message'] ?? "Gagal update iuran";
      }
    } on SocketException {
      throw "Terjadi Kesalahan Jaringan";
    } on TimeoutException {
      throw "Koneksi internet lambat, periksa jaringan Anda";
    } catch (e) {
      rethrow;
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
      throw "Terjadi Kesalahan Jaringan";
    } on TimeoutException {
      throw "Koneksi internet lambat, periksa jaringan Anda";
    } catch (e) {
      rethrow;
    }
  }

  Future<List<IuranPaidModel>> getPaidInvoices() async {
    try {
      final res = await http.get(
        Uri.parse('$iuran/getPaidInvoices'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${http.token}',
        },
      );

      if (res.statusCode == 200) {
        debugPrint("Invoice berhasil dilihat");
        final jsonResponse = jsonDecode(res.body);
        final List<IuranPaidModel> invoices = (jsonResponse["data"] as List)
            .map((e) => IuranPaidModel.fromJson(e))
            .toList();

        return invoices;
      } else {
        throw Exception("Failed to load invoices: ${res.statusCode}");
      }
    } on SocketException {
      throw "Terjadi Kesalahan Jaringan";
    } on TimeoutException {
      throw "Koneksi internet lambat, periksa jaringan Anda";
    } catch (e) {
      rethrow;
    }
  }

  Future<IuranModel> getInvoice() async {
    try {
      final res = await http.get(
        Uri.parse('$iuran/getInvoices'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${http.token}',
        },
      );

      if (res.statusCode == 200) {
        debugPrint("Invoice berhasil dilihat");
        final jsonResponse = jsonDecode(res.body);
        return IuranModel.fromJson(jsonResponse);
      } else {
        throw Exception("Failed to load invoice: ${res.statusCode}");
      }
    } on SocketException {
      throw "Terjadi Kesalahan Jaringan";
    } on TimeoutException {
      throw "Koneksi internet lambat, periksa jaringan Anda";
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PaymentChannelModel>> getChannels() async {
    try {
      var res = await http.get(Uri.parse(paymentChannel));

      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        var list = (json['data'] as List)
            .map((e) => PaymentChannelModel.fromJson(e))
            .toList();
        return list;
      }
      if (res.statusCode == 400) {
        throw json['message'] ?? "Terjadi kesalahan";
      } else {
        throw "Error";
      }
    } on SocketException {
      throw "Terjadi Kesalahan Jaringan";
    } on TimeoutException {
      throw "Koneksi internet lambat, periksa jaringan Anda";
    } catch (e) {
      rethrow;
    }
  }

  Future<String> checkoutItem({
    required PaymentChannelModel payment,
    required List<int> invoiceIds,
  }) async {
    try {
      final token = getIt<AppBloc>().state.token;
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var request = httpBase.Request('POST', Uri.parse(checkoutItems));

      Map<String, dynamic> requestBody = {
        "invoice_ids": invoiceIds,
        "payment_method": {
          "id": payment.id,
          "paymentType": payment.paymentType,
          "name": payment.name,
          "nameCode": payment.nameCode,
          "logo": payment.logo,
          "fee": payment.fee,
          "service_fee": payment.serviceFee,
          "platform": payment.platform,
          "howToUseUrl": payment.howToUseUrl,
          "createdAt": payment.createdAt,
          "updatedAt": payment.updatedAt,
          "deletedAt": payment.deletedAt,
        },
      };

      request.body = json.encode(requestBody);
      request.headers.addAll(headers);

      httpBase.StreamedResponse response = await request.send();
      var responseString = await response.stream.bytesToString();
      final decodedMap = json.decode(responseString);

      if (response.statusCode == 200) {
        var paymentNumber = decodedMap['data']['id'];

        return paymentNumber.toString();
      } else {
        throw decodedMap['message'] ?? "Terjadi kesalahan";
      }
    } catch (e) {
      debugPrint("Error: $e");
      rethrow;
    }
  }

  Future<IuranCountModel> getBadgesIuran() async {
    try {
      final res = await http.get(Uri.parse('$iuran/getUnpaidInvoiceCount'));

      debugPrint(res.body);
      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return IuranCountModel.fromJson(json['data']);
      } else {
        throw json['message'] ?? "Terjadi Kesalahan";
      }
    } catch (e) {
      rethrow;
    }
  }
}
