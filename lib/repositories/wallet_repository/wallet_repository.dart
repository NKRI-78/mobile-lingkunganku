import 'dart:convert';
import 'package:http/http.dart' as httpBase;
import '../../misc/api_url.dart';
import '../../misc/http_client.dart';
import '../../misc/injections.dart';
import '../../modules/app/bloc/app_bloc.dart';
import '../iuran_repository/models/payment_channel_model.dart';

class WalletRepository {
  String get topUp => '${MyApi.baseUrl}/api/v1/topup';
  final http = getIt<BaseNetworkClient>();

  Future<int> topUpWallet({
    required PaymentChannelModel payment,
    required int amountTopup,
  }) async {
    try {
      final token = getIt<AppBloc>().state.token;
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var request = httpBase.Request('POST', Uri.parse(topUp));
      request.body = json.encode({
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
          "deletedAt": payment.deletedAt
        },
        'amountTopup': amountTopup,
      });

      request.headers.addAll(headers);

      httpBase.StreamedResponse response = await request.send();
      var responseString = await response.stream.bytesToString();
      final decodedMap = json.decode(responseString);

      if (response.statusCode == 200) {
        final paymentId = decodedMap['data']?['paymentModel']?['id'];

        if (paymentId is int) {
          return paymentId;
        } else {
          throw "ID transaksi tidak ditemukan";
        }
      } else {
        throw decodedMap['message'] ?? "Terjadi kesalahan";
      }
    } catch (e) {
      rethrow;
    }
  }
}
