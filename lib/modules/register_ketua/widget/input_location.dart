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
          height: 200.0,
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Stack(children: [
            GoogleMap(
              mapType: MapType.normal,
              gestureRecognizers: {}..add(Factory<EagerGestureRecognizer>(
                  () => EagerGestureRecognizer())),
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(st.latitude, st.longitude),
                zoom: 15.0,
              ),
              markers: Set.from(markers),
              onMapCreated: (GoogleMapController controller) {
                mapsController.complete(controller);
                context.read<RegisterKetuaCubit>().setAreaCurrent(controller);
                RegisterKetuaCubit.googleMapCheckIn = controller;
              },
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     margin: const EdgeInsets.only(
            //         bottom: 10.0, right: 40.0, left: 10.0),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(5.0),
            //         color: AppColors.whiteColor),
            //     width: 210.0,
            //     height: 90.0,
            //     child: Container(
            //       margin: const EdgeInsets.all(10),
            //       child: Text(st.currentAddress,
            //           style: const TextStyle(
            //             fontSize: 12,
            //             color: AppColors.blackColor,
            //           )),
            //     ),
            //   ),
            // )
          ]));
    });
  }
}
