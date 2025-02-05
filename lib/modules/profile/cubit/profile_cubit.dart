import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_lingkunganku/misc/http_client.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';

import '../../../misc/api_url.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit()
      : super(const ProfileState(
          chiefReferral: '',
          familyReferral: '',
          errorMessage: null,
        ));

  Future<void> loadProfile() async {
    try {
      final token = getIt<BaseNetworkClient>().token;

      final response = await http.get(
        Uri.parse('${MyApi.baseUrl}/api/v1/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        processProfileData(responseData);
      } else {
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        throw Exception(errorResponse['message'] ?? "Gagal mengambil data");
      }
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
      ));
    }
  }

  void processProfileData(Map<String, dynamic> responseData) {
    if (!responseData.containsKey('data') || responseData['data'] == null) {
      return;
    }

    final Map<String, dynamic> data = responseData['data'];

    final String chiefReferral = data['chief']?['referral']?.toString() ?? '';
    final String familyReferral = data['family']?['referral']?.toString() ?? '';

    emit(state.copyWith(
      chiefReferral: chiefReferral,
      familyReferral: familyReferral,
    ));
  }
}
