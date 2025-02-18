import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../misc/http_client.dart';
import '../../../misc/injections.dart';
import 'models/place_autocomplete.dart';

class GoogleMapApiRepository {
  GoogleMapApiRepository();

  final http = getIt<BaseNetworkClient>();

  String apiKey = 'AIzaSyCJD7w_-wHs4Pe5rWMf0ubYQFpAt2QF2RA';

  String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?';

  String urlCoor(String placeId) =>
      'https://maps.googleapis.com/maps/api/geocode/json?place_id=$placeId&key=$apiKey';

  Future<List<PlaceAutocomplete>> getPlace(String text) async {
    final response = await http.get(
      Uri.parse('${url}input=$text&radius=1500&key=$apiKey&language=id'),
    );
    // print(response.data);

    if (response.statusCode == 200) {
      final data = response.body;
      List predictions = jsonDecode(data)['predictions'];
      final locationModels = predictions.map((prediction) {
        return PlaceAutocomplete(
          prediction['description'] ?? '',
          prediction['place_id'] ?? '',
        );
      }).toList();

      return locationModels;
    } else {
      return [];
    }
  }

  Future<LatLng?> getCoordinatePlace(String placeId) async {
    final response = await http.get(Uri.parse(urlCoor(placeId)));

    print("Response Maps $response");
    print("Place ID $placeId");

    if (response.statusCode == 200) {
      final data = response.body;
      final results = jsonDecode(data)['results'] as List;
      final result = results.first;
      // print(result);
      final location = result['geometry']['location'];
      return LatLng(location['lat'] ?? 0, location['lng'] ?? 0);
    }
    return null;
  }
}
