import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

var baseTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    background: Colors.white,
  ),
  appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  )),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);

const String imageDefault = "assets/images/no_image.png";
const String avatarDefault = "assets/images/default.jpg";

const String noData = "assets/images/no-data.png";
