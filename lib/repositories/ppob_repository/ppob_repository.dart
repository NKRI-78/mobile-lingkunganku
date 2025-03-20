import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as httpBase;
import 'models/pulsa_data_model.dart';

class PpobRepository {
  String get ppob => 'https://api-ppob.langitdigital78.com/api/v1/ppob/info';

  Future<List<PulsaDataModel>> fetchPulsaData({
    required String prefix,
    required String type,
  }) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      final uri =
          Uri.parse("$ppob/price-list-pulsa-data?prefix=$prefix&type=$type");

      debugPrint("📡 Fetching pulsa data...");
      debugPrint("🌍 API Request: $uri");
      debugPrint("📌 Headers: $headers");

      final response = await httpBase
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 10));

      debugPrint("📩 Response Status Code: ${response.statusCode}");
      debugPrint("📩 Response Body: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception(
            "Failed to fetch data. Status code: ${response.statusCode}");
      }

      final Map<String, dynamic> decodedMap = json.decode(response.body);
      debugPrint("📝 Decoded Response: $decodedMap");

      if (decodedMap['error'] == true) {
        throw Exception(decodedMap['message'] ?? "Error fetching data");
      }

      if (decodedMap.containsKey('data') && decodedMap['data'] is List) {
        final List<dynamic> dataList = decodedMap['data'];
        debugPrint(dataList.isEmpty
            ? "⚠️ Data kosong dari API."
            : "✅ Data ditemukan: ${dataList.length} items");

        return dataList.map((json) => PulsaDataModel.fromJson(json)).toList();
      } else {
        throw Exception("Invalid response format");
      }
    } on FormatException catch (e) {
      debugPrint("❌ JSON Format Error: $e");
      throw Exception("Invalid response format");
    } on httpBase.ClientException catch (e) {
      debugPrint("❌ HTTP Client Error: $e");
      throw Exception("Network error, please check your connection");
    } on TimeoutException {
      debugPrint("⏳ Request timeout!");
      throw Exception("Request timeout, server not responding");
    } catch (e) {
      debugPrint("❌ Unexpected Error: $e");
      throw Exception("Failed to fetch pulsa & data: $e");
    }
  }
}
