import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'colors.dart';
import 'snackbar.dart';

class FileStorage {
  static bool _isImage(String filename) {
    return filename.toLowerCase().endsWith('.png') ||
        filename.toLowerCase().endsWith('.jpg') ||
        filename.toLowerCase().endsWith('.jpeg');
  }

  static bool _isVideo(String filename) {
    return filename.toLowerCase().endsWith('.mp4') ||
        filename.toLowerCase().endsWith('.mov');
  }

  static Future<String> getProperDirectory(String filename) async {
    if (Platform.isAndroid) {
      final status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) throw Exception('Permission ditolak');

      String basePath;
      if (_isImage(filename)) {
        basePath = '/storage/emulated/0/Pictures/LINGKUNGANKU-MOBILE';
      } else if (_isVideo(filename)) {
        basePath = '/storage/emulated/0/Movies/LINGKUNGANKU-MOBILE';
      } else {
        basePath = '/storage/emulated/0/Documents/LINGKUNGANKU-MOBILE';
      }

      final dir = Directory(basePath);
      if (!await dir.exists()) await dir.create(recursive: true);
      return basePath;
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/LINGKUNGANKU-MOBILE';
      await Directory(path).create(recursive: true);
      return path;
    }
  }

  static Future<String> getFileFromAsset(
      String filename, BuildContext context, bool isExistFile) async {
    final path = await getProperDirectory(filename);
    final filePath = '$path/$filename';

    debugPrint('Filename : $filePath');

    final snackBar = SnackBar(
      backgroundColor:
          isExistFile ? AppColors.redColor : AppColors.secondaryColor,
      duration: const Duration(seconds: 5),
      content: Text(
        "${isExistFile ? 'File sudah ada di' : 'File berhasil diunduh, File disimpan ke'} $filePath",
        style: const TextStyle(
            color: AppColors.whiteColor, fontWeight: FontWeight.w700),
      ),
      action: SnackBarAction(
        label: 'Lihat',
        textColor: AppColors.whiteColor,
        onPressed: () async {
          final result = await OpenFile.open(filePath);
          Future.delayed(Duration.zero, () {
            result.type.name != "noAppToOpen"
                ? ShowSnackbar.snackbar(context, "Successfully opened the file",
                    '', AppColors.secondaryColor)
                : ShowSnackbar.snackbar(
                    context, result.message, '', AppColors.redColor);
          });
        },
      ),
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return filePath;
  }

  static Future<bool> checkFileExist(String filename) async {
    final path = await getProperDirectory(filename);
    final file = File('$path/$filename');
    return file.exists();
  }

  static Future<File> saveFile(Uint8List bytes, String filename) async {
    final path = await getProperDirectory(filename);
    final folder = Directory(path);

    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    final file = File('${folder.path}/$filename');
    return file.writeAsBytes(bytes);
  }

  static Future<File> saveFileUrl(Uint8List bytes, String filename) async {
    final path = await getProperDirectory(filename);
    final folder = Directory(path);

    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    final filePath = '${folder.path}/$filename';
    final file = File(filePath);

    // Write bytes to file
    await file.writeAsBytes(bytes);

    // Save to gallery if image or video
    if (_isImage(filename) || _isVideo(filename)) {
      // Jangan simpan lagi ke gallery jika sudah berada di folder gallery (Pictures/Movies)
      // Karena akan duplicate
      debugPrint(
          "File image/video sudah disimpan di folder gallery, skip GallerySaver.");
    }

    return file;
  }
}
