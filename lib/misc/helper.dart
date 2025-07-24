import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {
  static double convertGramsToKg(double grams) {
    return grams / 1000;
  }

  static Future<void> openLink(
      {required String url, required BuildContext context}) async {
    final uri = Uri.parse(url);

    // if(!url.contains(RegExp(r'^(http|https)://'))){
    //   ShowSnackbar.snackbar(context, "Kata Sandi minimal 8 character", '',
    //       errorColor);
    // }

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}

class UpgraderMessagesIndonesian extends UpgraderMessages {
  UpgraderMessagesIndonesian() : super(code: 'id');

  @override
  String get title => 'Pembaruan Tersedia';

  @override
  String get body =>
      'Versi terbaru dari {{appName}} tersedia! Versi terbaru saat ini adalah {{currentAppStoreVersion}} - versi anda saat ini adalah {{currentInstalledVersion}}.';

  @override
  String get prompt => 'Mau perbarui sekarang?';

  @override
  String get releaseNotes => 'Catatan Rilis';

  @override
  String get buttonTitleUpdate => 'Perbarui Sekarang';

  @override
  String get buttonTitleIgnore => 'Abaikan';

  @override
  String get buttonTitleLater => 'Nanti Saja';
}
