import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'colors.dart';
import 'snackbar.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    Directory? directory;

    if (Platform.isAndroid) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final exPath = directory.path;
    await Directory("$exPath/LINGKUNGANKU-MOBILE").create(recursive: true);
    return exPath;
  }

  static Future<String> get localPath async {
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<String> getFileFromAsset(
      String filename, BuildContext context, bool isExistFile) async {
    final path = await localPath;
    debugPrint('Filename : $path/LINGKUNGANKU-MOBILE/$filename');
    final snackBar = SnackBar(
      backgroundColor:
          isExistFile ? AppColors.redColor : AppColors.secondaryColor,
      duration: const Duration(seconds: 5),
      content: Text(
        "${isExistFile ? 'File sudah ada di' : 'File berhasil diunduh, File disimpan ke'} $path/LINGKUNGANKU-MOBILE/$filename",
        style: const TextStyle(
            color: AppColors.whiteColor, fontWeight: FontWeight.w700),
      ),
      action: SnackBarAction(
        label: 'Lihat',
        textColor: AppColors.whiteColor,
        onPressed: () async {
          final result =
              await OpenFile.open('$path/LINGKUNGANKU-MOBILE/$filename');
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
    return "$path/LINGKUNGANKU-MOBILE/$filename";
  }

  static Future<bool> checkFileExist(String filename) async {
    final path = await localPath;
    debugPrint('Filename : $filename');
    File file = File('$path/LINGKUNGANKU-MOBILE/$filename');

    bool checkIsExist = await file.exists();
    if (checkIsExist) {
      return true;
    }

    return false;
  }

  static Future<File> saveFile(Uint8List bytes, String filename) async {
    final path = await localPath;
    debugPrint('Filename : $filename');
    File file = File('$path/LINGKUNGANKU-MOBILE/$filename');
    return file.writeAsBytes(bytes);
  }
}
