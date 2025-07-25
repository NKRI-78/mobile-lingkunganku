import 'package:flutter/material.dart';

import 'colors.dart';

class ShowSnackbar {
  ShowSnackbar._();
  static snackbar(
      BuildContext context, String content, String label, Color backgroundColor,
      [Duration? time]) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: time ?? const Duration(seconds: 2),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom,
          left: 16,
          right: 16,
        ),
        content: Text(
          content,
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
          ),
        ),
        action: SnackBarAction(
          textColor: AppColors.whiteColor,
          label: label,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }
}
