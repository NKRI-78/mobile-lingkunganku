part of '../view/register_ketua_page.dart';

class InputLocationLabel extends StatelessWidget {
  const InputLocationLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Wrap(
            spacing: 10.0,
            children: [
              Icon(
                Icons.location_city,
                color: AppColors.textColor2,
                size: 20,
              ),
              Text(
                "Lokasi",
                style: TextStyle(fontSize: 14, color: AppColors.textColor2),
              )
            ],
          ),
          const Expanded(child: SizedBox.shrink()),
          GestureDetector(
            onTap: () async {
              final add = await CustomSelectMapLocationWidget.go(context);
              if (add != null) {
                debugPrint(add.address);
                debugPrint("Lat result : ${add.latLng.latitude}");
                if (context.mounted) {
                  var cubit = context.read<RegisterKetuaCubit>();

                  cubit.copyState(
                      newState: cubit.state.copyWith(
                          latitude: add.latLng.latitude,
                          longitude: add.latLng.longitude,
                          currentAddress: add.address));

                  cubit.updateCurrentPositionCheckIn(
                      context, add.latLng.latitude, add.latLng.longitude);
                }
              }
            },
            child: const Text(
              "Tetapkan Lokasi",
              style: TextStyle(fontSize: 14, color: AppColors.textColor2),
            ),
          ),
        ],
      ),
    );
  }
}
