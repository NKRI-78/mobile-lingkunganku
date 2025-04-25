import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../router/router.dart';

import '../widgets/button/custom_button.dart';
import '../widgets/terms_of_services/term_condition.dart';
import 'colors.dart';
import 'text_style.dart';

class GeneralModal {
  static Future<void> showConfirmModal({
    required String msg,
    required BuildContext context,
    required void Function() onPressed,
    required String locationImage,
  }) async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      body: Column(
        children: [
          Image.asset(
            locationImage,
            width: 120.0,
            height: 120.0,
            fit: BoxFit.fill,
          ),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: AppTextStyles.textDialog.copyWith(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: 'Yakin',
                onPressed: onPressed,
              ),
              const SizedBox(width: 10),
              CustomButton(
                backgroundColor: AppColors.redColor,
                text: 'Batal',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    ).show();
  }

  static Future<Object?> termsAndCondition() async {
    return showDialog(
      context: myNavigatorKey.currentContext!,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) {
        return const TermCondition();
      },
    );
  }
}
