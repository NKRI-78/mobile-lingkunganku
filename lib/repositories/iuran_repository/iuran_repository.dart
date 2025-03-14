import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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

  Future<List<PaymentChannelModel>> getChannels() async {
    try {
      var res = await http.get(Uri.parse(paymentChannel));

      print(res.body);

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

      print("Request Body: ${request.body}");

      httpBase.StreamedResponse response = await request.send();
      var responseString = await response.stream.bytesToString();
      final decodedMap = json.decode(responseString);

      print("Response Status: ${response.statusCode}");
      print("Response Body: $decodedMap");

      if (response.statusCode == 200) {
        var paymentNumber = decodedMap['data']['id'];
        print("Payment Number: $paymentNumber");
        return paymentNumber.toString();
      } else {
        throw decodedMap['message'] ?? "Terjadi kesalahan";
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}
