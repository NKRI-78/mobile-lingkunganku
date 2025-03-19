import 'dart:convert';

import 'package:mobile_lingkunganku/misc/api_url.dart';
import 'package:mobile_lingkunganku/misc/http_client.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:http/http.dart' as httpBase;
import 'package:mobile_lingkunganku/repositories/ppob_repository/models/pulsa_data_model.dart';

import '../../modules/app/bloc/app_bloc.dart';

class PpobRepository {
  String get ppob => '${MyApi.baseUrlPpob}/api/v1/ppob/info';
  final http = getIt<BaseNetworkClient>();

  Future<List<PulsaDataModel>> fetchPulsaData({
    required String prefix,
    required String type,
  }) async {
    try {
      final token = getIt<AppBloc>().state.token;
      print("🔑 Token: $token");

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      print("📌 Headers: $headers");

      final uri =
          Uri.parse("$ppob/price-list-pulsa-data?prefix=$prefix&type=$type");
      print("🌍 API Request: $uri");

      final response = await httpBase.get(uri, headers: headers);
      print("📩 Response Status Code: ${response.statusCode}");
      print("📩 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final decodedMap = json.decode(response.body);

        if (decodedMap['error'] == true) {
          throw Exception(decodedMap['message'] ?? 'Error fetching data');
        }

        if (decodedMap.containsKey('data') && decodedMap['data'] is List) {
          return (decodedMap['data'] as List)
              .map((json) => PulsaDataModel.fromJson(json))
              .toList();
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Exception: $e");
      throw Exception('Failed to fetch pulsa & data: $e');
    }
  }
}
