import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import 'colors.dart';
import 'file_storage.dart';

class DownloadHelper {
  static Future<void> downloadDoc(
      {required BuildContext context, required String url}) async {
    int total = 0;
    int received = 0;

    late http.StreamedResponse response;

    final List<int> bytes = [];

    String originName = p.basename(url.split('/').last).split('.').first;
    String ext = p.basename(url).toString().split('.').last;

    String filename =
        "${DateFormat('yyyydd').format(DateTime.now())}-$originName.$ext";

    bool isExistFile = await FileStorage.checkFileExist(filename);

    if (!isExistFile && context.mounted) {
      ProgressDialog pr = ProgressDialog(context: context);
      pr.show(
          backgroundColor: AppColors.textColor,
          msgTextAlign: TextAlign.start,
          max: 100,
          msgColor: AppColors.whiteColor,
          msg: "Please wait...",
          progressBgColor: AppColors.greyColor,
          progressValueColor: AppColors.textColor,
          onStatusChanged: (status) async {
            if (status == DialogStatus.opened) {
              response =
                  await http.Client().send(http.Request('GET', Uri.parse(url)));

              total = response.contentLength ?? 0;

              response.stream.listen((value) {
                bytes.addAll(value);
                received = value.length;
                ProgressDialog pr = ProgressDialog(context: context);
                int progress = (((received / total) * 100).toInt());
                pr.update(value: progress, msg: 'File Downloading...');
              }).onDone(() async {
                pr.close();
                Uint8List uint8List = Uint8List.fromList(bytes);

                await FileStorage.saveFileUrl(uint8List, filename);
                // ignore: use_build_context_synchronously
                if (context.mounted) {
                  await FileStorage.getFileFromAsset(
                      filename, context, isExistFile);
                }
              });
            }
          });
    } else {
      if (context.mounted) {
        await FileStorage.getFileFromAsset(filename, context, isExistFile);
      }
    }
  }
}
