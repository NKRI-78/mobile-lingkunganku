import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
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
    if (Platform.isAndroid && Platform.version.contains('13')) {
      if (_isImage(filename)) {
        final photoPermission = await Permission.photos.request();
        if (!photoPermission.isGranted) {
          throw Exception('Permission ditolak untuk akses Foto');
        }
      } else if (_isVideo(filename)) {
        final videoPermission = await Permission.videos.request();
        if (!videoPermission.isGranted) {
          throw Exception('Permission ditolak untuk akses Video');
        }
      } else {
        final storagePermission = await Permission.storage.request();
        if (!storagePermission.isGranted) {
          throw Exception('Permission ditolak untuk akses Penyimpanan');
        }
      }

      final dir = await getExternalStorageDirectory(); // app-specific dir
      final path = '${dir!.path}/LINGKUNGANKU-MOBILE';

      final folder = Directory(path);
      if (!await folder.exists()) {
        await folder.create(recursive: true);
      }

      return path;
    } else {
      // iOS atau lainnya
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
        "${isExistFile ? 'File sudah ada di' : 'File berhasil diunduh, disimpan ke'} $filePath",
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
                ? ShowSnackbar.snackbar(
                    context,
                    "File berhasil dibuka",
                    '',
                    AppColors.secondaryColor,
                  )
                : ShowSnackbar.snackbar(
                    context,
                    result.message,
                    '',
                    AppColors.redColor,
                  );
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
    final file = File('$path/$filename');
    return file.writeAsBytes(bytes);
  }

  static Future<File> saveFileUrl(Uint8List bytes, String filename) async {
    final path = await getProperDirectory(filename);
    final filePath = '$path/$filename';
    final file = File(filePath);

    await file.writeAsBytes(bytes);

    // Save to gallery if image or video
    if (_isImage(filename)) {
      final result = await GallerySaver.saveImage(
        file.path,
        albumName: 'LINGKUNGANKU-MOBILE',
      );
      debugPrint("Save image to gallery result: ${result ?? 'null'}");
    } else if (_isVideo(filename)) {
      final result = await GallerySaver.saveVideo(
        file.path,
        albumName: 'LINGKUNGANKU-MOBILE',
      );
      debugPrint("Save video to gallery result: ${result ?? 'null'}");
    }

    return file;
  }
}
