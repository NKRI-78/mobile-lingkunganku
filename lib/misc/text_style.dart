import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextStyles {
  static TextStyle textStyle1 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor2,
    fontFamily: 'Inter',
  );
  static TextStyle textStyle2 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor2,
    fontFamily: 'Inter',
  );
  static TextStyle buttonText1 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: AppColors.whiteColor,
    fontFamily: 'Inter',
  );
  static TextStyle buttonText2 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.whiteColor,
    fontFamily: 'Inter',
  );
  static TextStyle textRegister1 = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.buttonColor1,
    fontFamily: 'Inter',
  );
  static TextStyle textRegister2 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor2,
    fontFamily: 'Inter',
  );

  AppTextStyles._();
}
