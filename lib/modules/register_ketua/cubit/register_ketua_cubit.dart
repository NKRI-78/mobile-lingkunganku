import 'dart:io';

import 'package:equatable/equatable.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

import '../../../widgets/map/custom_select_location.dart';

part 'register_ketua_state.dart';

class RegisterKetuaCubit extends Cubit<RegisterKetuaState> {
  RegisterKetuaCubit() : super(const RegisterKetuaState());

  static GoogleMapController? googleMapCheckIn;
  // MakeShopRepository repo = MakeShopRepository();
  void selectPenghuni(int value) {
    emit(state.copyWith(selectedPenghuni: value));
  }

  void togglePasswordVisibility() {
    emit(RegisterKetuaState(
      isPasswordObscured: !state.isPasswordObscured,
      isConfirmPasswordObscured: state.isConfirmPasswordObscured,
    ));
  }

  void toggleConfirmPasswordVisibility() {
    emit(RegisterKetuaState(
      isPasswordObscured: state.isPasswordObscured,
      isConfirmPasswordObscured: !state.isConfirmPasswordObscured,
    ));
  }

  void copyState(RegisterKetuaState newState) {
    emit(newState);
  }

  void setAreaCurrent(GoogleMapController mapController) async {
    Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    emit(state.copyWith(
        latitude: position.latitude,
        longitude: position.longitude,
        currentAddress:
            "${place.thoroughfare} ${place.subThoroughfare} \n${place.locality}, ${place.postalCode}"));

    mapController.moveCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
    mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(state.latitude, state.longitude),
      zoom: 15.0,
    )));
  }

  Future<void> updateCurrentPositionCheckIn(
      BuildContext context, double lat, double lng) async {
    try {
      googleMapCheckIn?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 15.0)));
    } catch (e, stacktrace) {
      debugPrint(stacktrace.toString());
    }
  }

  /// Memperbarui data alamat toko dan lokasi
  // void updateShopAddress({
  //   String? address,
  //   String? province,
  //   String? city,
  //   String? subDistrict,
  //   String? postalCode,
  //   String? district,
  //   LatLng? location,
  // }) {
  //   emit(state.copyWith(
  //     registerAddress: address,
  //     province: province,
  //     city: city,
  //     subDistrict: subDistrict,
  //     postalCode: postalCode,
  //     district: district,
  //     registerLocation: location,
  //   ));
  // }

  // Future<void> chooseFile(BuildContext context) async {
  //   // Tampilkan dialog untuk memilih sumber gambar (kamera atau galeri)
  //   ImageSource? imageSource = await showDialog<ImageSource>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: const Text("Source Image"),
  //       actions: [
  //         MaterialButton(
  //           child: const Text("Camera"),
  //           onPressed: () async {
  //             try {
  //               // Meminta izin kamera
  //               if (await Permission.camera.request().isGranted) {
  //                 // Jika izin diberikan, kembalikan ImageSource.camera
  //                 Navigator.pop(context, ImageSource.camera);
  //               } else if (await Permission.camera.request().isDenied ||
  //                   await Permission.camera.request().isPermanentlyDenied) {
  //                 // Jika izin ditolak, tampilkan pesan error
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(
  //                     backgroundColor: Colors.red,
  //                     content: Text(
  //                       "Camera permission needed, please activate your camera",
  //                       style: TextStyle(color: Colors.white),
  //                     ),
  //                   ),
  //                 );
  //               } else {
  //                 // Jika pengguna membatalkan, tutup dialog
  //                 Navigator.pop(context);
  //               }
  //             } catch (e) {
  //               debugPrint(e.toString());
  //             }
  //           },
  //         ),
  //         MaterialButton(
  //           child: const Text("Gallery"),
  //           onPressed: () async {
  //             // Meminta izin galeri atau penyimpanan
  //             if (await Permission.photos.request().isGranted ||
  //                 await Permission.storage.request().isGranted) {
  //               // Jika izin diberikan, kembalikan ImageSource.gallery
  //               Navigator.pop(context, ImageSource.gallery);
  //             } else if (await Permission.photos.request().isDenied ||
  //                 await Permission.storage.request().isDenied) {
  //               // Jika izin ditolak, tampilkan pesan error
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(
  //                   backgroundColor: Colors.red,
  //                   content: Text(
  //                     "Storage permission needed, please activate your storage",
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                 ),
  //               );
  //             } else {
  //               // Jika pengguna membatalkan, tutup dialog
  //               Navigator.pop(context);
  //             }
  //           },
  //         ),
  //       ],
  //     ),
  //   );

  //   // Jika pengguna memilih sumber gambar
  //   if (imageSource != null) {
  //     File? imageResult;

  //     if (imageSource == ImageSource.gallery) {
  //       // Memilih gambar dari galeri
  //       FilePickerResult? result = await FilePicker.platform.pickFiles(
  //         type: FileType.image,
  //       );

  //       if (result != null && result.files.isNotEmpty) {
  //         // Ambil file yang dipilih
  //         imageResult = File(result.files.single.path!);
  //       }
  //     } else {
  //       // Mengambil gambar dari kamera
  //       final ImagePicker picker = ImagePicker();
  //       XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

  //       if (pickedFile != null) {
  //         // Ambil file yang diambil dari kamera
  //         imageResult = File(pickedFile.path);
  //       }
  //     }

  //     // Jika gambar berhasil dipilih, simpan ke state
  //     if (imageResult != null) {
  //       // Misalnya, simpan ke state menggunakan Cubit atau StatefulWidget
  //       // context.read<YourCubit>().updateImage(imageResult);
  //       emit(state.copyWith(fileImage: imageResult));
  //       debugPrint("Image selected: ${imageResult.path}");
  //     } else {
  //       debugPrint("No image selected");
  //     }
  //   }
  // }

  // /// Mengunggah gambar ke API
  // Future<String> uploadImage(File imageFile) async {
  //   try {
  //     // Ganti URL dengan endpoint API Anda
  //     const String apiUrl = 'http://157.245.193.49:3099/api/v1/store';

  //     // Buat request
  //     var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'file', // Sesuaikan dengan nama field di API
  //         imageFile.path,
  //       ),
  //     );

  //     // Kirim request
  //     var response = await request.send();

  //     if (response.statusCode == 200) {
  //       // Jika berhasil, kembalikan URL gambar
  //       final responseData = await response.stream.bytesToString();
  //       return responseData; // Sesuaikan dengan struktur response API
  //     } else {
  //       throw Exception("Failed to upload image");
  //     }
  //   } catch (e) {
  //     debugPrint("Error uploading image: $e");
  //     throw e;
  //   }
  // }

  // Future<void> chooseLocation(BuildContext context) async {
  //   final location = await CustomSelectMapLocationWidget.go(context);
  //   if (location != null) {
  //     debugPrint("Lokasi terpilih: ${location.latLng}");
  //     context.read<RegisterKetuaCubit>().updateShopLocation(location.latLng);
  //   } else {
  //     debugPrint("Pemilihan lokasi dibatalkan");
  //   }
  // }

  // Future<void> fetchBanner() async {
  //   try {
  //     // Ganti URL dengan endpoint API Anda
  //     const String apiUrl =
  //         'https://api-tentang-voucher.inovatiftujuh8.com/api/banner';

  //     // Lakukan request GET ke API
  //     final response = await http.get(Uri.parse(apiUrl));

  //     if (response.statusCode == 200) {
  //       // Decode response JSON
  //       final Map<String, dynamic> data = json.decode(response.body);

  //       // Simpan URL banner ke state
  //       emit(state.copyWith(bannerUrl: data['bannerUrl']));
  //     } else {
  //       throw Exception("Failed to load banner");
  //     }
  //   } catch (e) {
  //     debugPrint("Error fetching banner: $e");
  //   }
  // }
}
