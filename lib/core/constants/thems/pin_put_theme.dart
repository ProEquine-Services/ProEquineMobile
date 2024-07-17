import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../../utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../colors/app_colors.dart';

class PinThemeConst {
  static final defaultPinTheme = PinTheme(
    width: 40,
    height: 52,
    margin: const EdgeInsets.symmetric(horizontal: 5),
    textStyle: TextStyle(
        fontSize: 14.sp,
        color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
            ? Colors.white
            : AppColors.blackLight,
        fontWeight: FontWeight.w600,
        fontFamily: 'hemiHead'),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          width: 2.0,
          color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
              ? const Color(0xff555D68)
              : AppColors.borderColor,
        ),
        left: BorderSide(
          width: 2.0,
          color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
              ? const Color(0xff555D68)
              : AppColors.borderColor,
        ),
        right: BorderSide(
          width: 2.0,
          color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
              ? const Color(0xff555D68)
              : AppColors.borderColor,
        ),
        bottom: BorderSide(
          width: 5,
          color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
              ? const Color(0xff555D68)
              : AppColors.borderColor,
        ),
      ),
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? AppColors.formsBackground
          : AppColors.formsBackgroundLight,
    ),
  );

  static final focusedPinTheme = PinTheme(
    width: 48,
    height: 63,
    margin: const EdgeInsets.symmetric(horizontal: 5),
    textStyle: TextStyle(
        fontSize: 14.sp,
        color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
            ? Colors.white
            : AppColors.blackLight,
        fontWeight: FontWeight.w600,
        fontFamily: 'hemiHead'),
    decoration: BoxDecoration(
      border: const Border(
        left: BorderSide(width: 2.0, color: AppColors.gold),
        top: BorderSide(width: 2.0, color: AppColors.gold),
        right: BorderSide(width: 2.0, color: AppColors.gold),
        bottom: BorderSide(width: 6.0, color: AppColors.gold),
      ),
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? AppColors.formsBackground
          : AppColors.formsBackgroundLight,
    ),
  );

  static final submittedPinTheme = PinTheme(
    width: 48,
    height: 63,
    margin: const EdgeInsets.symmetric(horizontal: 5),
    textStyle: TextStyle(
        fontSize: 14.sp,
        color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
            ? Colors.white
            : AppColors.blackLight,
        fontWeight: FontWeight.w600,
        fontFamily: 'hemiHead'),
    decoration: BoxDecoration(
      border: const Border(
        bottom: BorderSide(width: 8.0, color: AppColors.gold),
      ),
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? AppColors.formsBackground
          : AppColors.formsBackgroundLight,
    ),
  );
}
