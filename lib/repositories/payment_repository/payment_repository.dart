import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../misc/api_url.dart';
import '../../misc/http_client.dart';
import '../../misc/injections.dart';
import 'models/payment_channel_model.dart';
import 'models/payment_model.dart';

class PaymentRepository {
  Uri get paymentChannel =>
      Uri.parse('http://157.245.193.49:6720/api/v1/channel');

  Uri findPaymentUri(String id) =>
      Uri.parse('${MyApi.baseUrl}/api/v1/payment/detail/$id');

  final http = getIt<BaseNetworkClient>();

  Future<PaymentModel> findPayment(String paymentNumber) async {
    try {
      var res = await http.get(findPaymentUri((paymentNumber)));

      debugPrint(res.body);

      final json = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return PaymentModel.fromJson(json['data']);
      }
      if (res.statusCode == 400) {
        throw json['message'] ?? "Terjadi kesalahan";
      } else {
        throw "Error";
      }
    } on SocketException {
      throw "Terjadi kesalahan jaringan";
    }
  }

  Future<List<PaymentChannelModel>> getChannels() async {
    try {
      var res = await http.get(paymentChannel);

      debugPrint(res.body);

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
      throw "Terjadi kesalahan jaringan";
    }
  }
}
