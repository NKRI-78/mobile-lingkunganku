part of '../view/register_ketua_page.dart';

class InputLocation extends StatelessWidget {
  const InputLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterKetuaCubit, RegisterKetuaState>(
      builder: (context, st) {
        Completer<GoogleMapController> mapsController = Completer();
        List<Marker> markers = [];
        markers.add(Marker(
          markerId: const MarkerId("currentPosition"),
          position: LatLng(st.latitude, st.longitude),
          icon: BitmapDescriptor.defaultMarker,
        ));
        debugPrint("Lat Checkin ${st.latitude}");
        debugPrint("Long Checkin ${st.longitude}");
        return Container(
          width: double.infinity,
          height: 150.0,
          margin: const EdgeInsets.only(left: 0, right: 0, bottom: 15),
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                gestureRecognizers: {}..add(Factory<EagerGestureRecognizer>(
                    () => EagerGestureRecognizer())),
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(st.latitude, st.longitude),
                  zoom: 10.0,
                ),
                markers: Set.from(markers),
                onMapCreated: (GoogleMapController controller) {
                  mapsController.complete(controller);
                  context.read<RegisterKetuaCubit>().setAreaCurrent(controller);
                  RegisterKetuaCubit.googleMapCheckIn = controller;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
