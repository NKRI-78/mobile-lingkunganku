import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../misc/colors.dart';
import '../../misc/keyboard_visibility.dart';
import '../../misc/location.dart';
import '../../repositories/google_map_api_repository/src/google_map_api_repository.dart';
import '../../repositories/google_map_api_repository/src/models/place_autocomplete.dart';

class AddressPickerCustomData {
  final String address;
  final LatLng latLng;

  const AddressPickerCustomData({this.address = '', required this.latLng});
}

class CustomSelectMapLocationWidget extends StatefulWidget {
  const CustomSelectMapLocationWidget({super.key});

  static Future<AddressPickerCustomData?> go(BuildContext context) async {
    return Navigator.push<AddressPickerCustomData?>(
      context,
      MaterialPageRoute(
        builder: (_) => const CustomSelectMapLocationWidget(),
      ),
    );
  }

  @override
  State<CustomSelectMapLocationWidget> createState() =>
      _CustomSelectMapLocationWidgetState();
}

class _CustomSelectMapLocationWidgetState
    extends State<CustomSelectMapLocationWidget> {
  GoogleMapController? mapController;

  Future<void> onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController = controller;
    });

    final position = await determinePosition(context);
    controller.moveCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
    markers = [
      Marker(
        markerId: const MarkerId("pin-point"),
        position: LatLng(position.latitude, position.longitude),
      )
    ];
    geocode();
    setState(() {});
  }

  List<Marker> markers = [];

  bool loading = false;
  String address = '';
  List<PlaceAutocomplete> places = [];

  void geocode() async {
    if (markers.isEmpty) return;
    loading = true;
    final place = await placemarkFromCoordinates(
        markers.first.position.latitude, markers.first.position.longitude);

    final street = place.first.street;
    final administrative = place.first.administrativeArea;
    final country = place.first.country;

    setState(() {
      address = '$street, $administrative, $country';
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Pin Titik Lokasi"),
        centerTitle: true,
      ),
      body: KeyboardVisibility(builder: (context, vis, height) {
        return Stack(
          children: [
            GoogleMap(
              onMapCreated: onMapCreated,
              onTap: (latLong) {
                markers = [
                  Marker(
                      markerId: const MarkerId("pin-point"), position: latLong)
                ];
                geocode();
                setState(() {});
              },
              markers: markers.toSet(),
              initialCameraPosition: const CameraPosition(
                zoom: 15,
                target: LatLng(-6.200000, 106.816666),
              ),
            ),

            /// search map
            Positioned(
              top: 8,
              left: 16,
              right: 16,
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      constraints: const BoxConstraints(minHeight: 50),
                      width: double.infinity,
                      child: TextField(
                        onChanged: onTyping,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(fontSize: 12),
                          filled: true,
                          suffixIcon: const Icon(
                            Icons.search_rounded,
                          ),
                          contentPadding:
                              const EdgeInsets.only(left: 16, top: 16),
                          hintText: "Cari...",
                          fillColor: AppColors.whiteColor,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (places.isNotEmpty)
                      Container(
                        constraints: const BoxConstraints(
                          minWidth: double.infinity,
                          maxHeight: 400,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(top: 6),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: places
                                .map(
                                  (e) => Column(
                                    children: [
                                      ListTile(
                                        onTap: () => choosePlace(e),
                                        leading: const Icon(
                                          Icons.location_on,
                                        ),
                                        title: Text(
                                          e.title,
                                          style: const TextStyle(fontSize: 14),
                                          maxLines: 5,
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),

            if (!vis && markers.isNotEmpty)
              Positioned(
                  left: 16,
                  right: 16,
                  bottom: 8,
                  child: SafeArea(
                      child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.whiteColor,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 3,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                padding: const EdgeInsets.all(2),
                                child: const Icon(
                                  Icons.location_on,
                                  size: 30,
                                  color: AppColors.redColor,
                                )),
                            const SizedBox(
                              width: 8,
                            ),
                            if (loading)
                              const Flexible(
                                  child: CircularProgressIndicator.adaptive())
                            else
                              Flexible(
                                  child: Text(
                                address,
                                style: const TextStyle(
                                    color: AppColors.blackColor),
                              ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: loading
                              ? null
                              : () {
                                  if (markers.isEmpty) {
                                    return;
                                  }
                                  AddressPickerCustomData? popdata;
                                  if (markers.isNotEmpty) {
                                    popdata = AddressPickerCustomData(
                                      latLng: LatLng(
                                        markers.first.position.latitude,
                                        markers.first.position.longitude,
                                      ),
                                      address: address.isEmpty ? '-' : address,
                                    );
                                  }
                                  Navigator.pop(
                                    context,
                                    popdata,
                                  );
                                },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: loading
                                      ? Colors.grey
                                      : Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(6)),
                            width: double.infinity,
                            height: 40,
                            child: Center(
                              child: Text(
                                'Pilih Alamat',
                                style: TextStyle(
                                    color:
                                        loading ? null : AppColors.blackColor),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )))
          ],
        );
      }),
    );
  }

  Timer? _delay;
  void onTyping(String value) {
    if (_delay?.isActive ?? false) _delay?.cancel();
    _delay = Timer(const Duration(milliseconds: 500), () {
      onSearch(value);
    });
  }

  Future<void> onSearch(String value) async {
    try {
      final placeList = await GoogleMapApiRepository().getPlace(value);
      setState(() {
        places = placeList;
      });
    } catch (e) {
      //
    }
  }

  Future<void> choosePlace(PlaceAutocomplete auto) async {
    try {
      FocusScope.of(context).unfocus();
      setState(() {
        places = [];
      });
      final location =
          await GoogleMapApiRepository().getCoordinatePlace(auto.placeId);
      if (location != null) {
        mapController?.moveCamera(
          CameraUpdate.newLatLng(
            LatLng(location.latitude, location.longitude),
          ),
        );
        markers = [
          Marker(
              markerId: const MarkerId("pin-point"),
              position: LatLng(location.latitude, location.longitude))
        ];
        setState(() {});
        geocode();
      }
    } catch (e) {
      //
    }
  }
}

Future<String> geocodeParsing(LatLng lng) async {
  try {
    final place = await placemarkFromCoordinates(lng.latitude, lng.longitude);

    final street = place.first.street;
    final administrative = place.first.administrativeArea;
    final country = place.first.country;

    var address = '$street, $administrative, $country';

    return address;
  } catch (e) {
    return '-';
  }
}
