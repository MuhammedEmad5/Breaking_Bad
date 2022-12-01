import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    primaryColor: AppColors.greyWhite,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: const AppBarTheme(
    color: AppColors.yellow,
    titleTextStyle: TextStyle(color: AppColors.darkBlue, fontSize: 22),
  ));
}

