import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Helper {
  static double convertGramsToKg(double grams) {
    return grams / 1000;
  }

  static Future<void> openLink({required String url, required BuildContext context}) async {
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