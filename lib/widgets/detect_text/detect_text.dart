import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../misc/snackbar.dart';

class DetectText extends StatelessWidget {
  final String text;
  final String? userid;
  final Color? colorText;
  final int? trimLength;
  const DetectText(
      {super.key,
      required this.text,
      this.userid,
      this.trimLength,
      this.colorText = AppColors.blackColor});

  @override
  Widget build(BuildContext context) {
    return DetectableText(
      text: text,
      trimLines: 3,
      trimLength: trimLength ?? 300,
      trimExpandedText: ' Tampilkan Lebih Sedikit',
      trimCollapsedText: 'Baca selengkapnya',
      detectionRegExp: RegExp(
          r'[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)|@[a-zA-Z0-9_.]+?(?![a-zA-Z0-9_.]|[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$)'),
      detectedStyle: const TextStyle(
          color: AppColors.secondaryColor, fontSize: 14, fontFamily: 'SF Pro'),
      basicStyle: TextStyle(
          color: colorText,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'SF Pro'),
      moreStyle: const TextStyle(
          color: AppColors.secondaryColor, fontSize: 14, fontFamily: 'SF Pro'),
      lessStyle: const TextStyle(
          color: AppColors.secondaryColor, fontSize: 14, fontFamily: 'SF Pro'),
      onTap: (tappedText) {
        final email = tappedText.contains(
            RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'));
        final mention =
            tappedText.contains(RegExp(r'^@[a-zA-Z0-9_.]+?(?![a-zA-Z0-9_.])'));
        debugPrint(tappedText);

        if (email) {
          launchEmailSubmission(tappedText, context);
        } else if (mention) {
          return null;
        } else {
          // WebViewScreenRoute(title: "ATJ-Mobile", url: tappedText.toLowerCase()).go(context);
        }
      },
    );
  }

  void launchEmailSubmission(String email, BuildContext context) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      await Clipboard.setData(ClipboardData(text: email));
      // ignore: use_build_context_synchronously
      ShowSnackbar.snackbar(
        context,
        "Content copied to clipboard",
        '',
        AppColors.secondaryColor,
        const Duration(seconds: 6),
      );
      debugPrint('Could not launch $params');
    }
  }
}
