import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../colors/app_colors.dart';

class AppStyles {
  /// Bold font

  static TextStyle summaryTitleStyle = const TextStyle(
      fontSize: 15,
      fontFamily: 'notosan',
      fontWeight: FontWeight.w700,
      color: AppColors.gold);
  static TextStyle summaryDesStyle = const TextStyle(
      fontSize: 13,
      fontFamily: 'notosan',
      fontWeight: FontWeight.w400,
      color: Color(0xff8B9299));

  /// Regular font

  static final mainFont = TextStyle(
      fontFamily: 'notosan',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? Colors.white
          : AppColors.blackLight);

  static final mainContent = TextStyle(
      fontFamily: 'notosan',
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? Colors.white
          : Colors.black);

  static const bookingContent = TextStyle(
    color: AppColors.formsHintFontLight,
    fontSize: 13,
    fontFamily: 'Noto Sans',
    fontWeight: FontWeight.w600,
  );

  /// Registration flow title style

  static final mainTitle = TextStyle(
      fontSize: 26,
      fontFamily: "notosan",
      fontWeight: FontWeight.w700,
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? Colors.white
          : AppColors.blackLight);
  static const buttonStyle = TextStyle(
      fontSize: 17,
      fontFamily: "notosan",
      fontWeight: FontWeight.w600,
      color: AppColors.whiteLight);

  static final mainTitle2 = TextStyle(
      fontSize: 20,
      fontFamily: "notosan",
      fontWeight: FontWeight.w700,
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? Colors.white
          : AppColors.blackLight);

  static final appBarTitle = TextStyle(
      fontSize: 17,
      fontFamily: "notosan",
      fontWeight: FontWeight.w600,
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? Colors.white
          : AppColors.blackLight);

  static final elevatedButtonTitle = TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      fontFamily: "notosan",
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? Colors.white
          : AppColors.blackLight);
  static final buttonTitle = TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      fontFamily: "notosan",
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? Colors.white
          : Colors.white);

  static final profileHeader = TextStyle(
    fontSize: 20.sp,
    fontFamily: "hemiHead",
    fontWeight: FontWeight.w500,
  );

  static final descriptions = TextStyle(
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? Colors.white
          : Colors.black,
      fontFamily: 'notosan',
      fontSize: 11.sp,
      fontWeight: FontWeight.w400);
  static final currentData = TextStyle(
      color: AppColors.blackLight,
      fontFamily: 'notosan',
      fontSize: 11.sp,
      fontWeight: FontWeight.w400);
  static const profileTitles = TextStyle(
      color: AppColors.gold,
      fontFamily: 'notosan',
      fontSize: 16,
      fontWeight: FontWeight.w700);
  static const profileBlackTitles = TextStyle(
      color: AppColors.blackLight,
      fontFamily: 'notosan',
      fontSize: 17,
      fontWeight: FontWeight.w700);

  final darkTheme = ThemeData(
    primaryColor: Colors.black,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // background (button) color
          foregroundColor: Colors.black,
          textStyle: AppStyles.elevatedButtonTitle // foreground (text) color
          ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: Colors.orange, fontSize: 16, fontWeight: FontWeight.w400),
      displayMedium: TextStyle(
          color: Colors.orange, fontSize: 16, fontWeight: FontWeight.w400),
      displaySmall: TextStyle(
          color: Colors.orange, fontSize: 16, fontWeight: FontWeight.w400),
      titleLarge: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
      titleMedium: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
      titleSmall: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
      headlineLarge: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(
          color: Colors.orange, fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(color: Colors.deepOrange),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.white
              : AppColors.white,
        ),
        textStyle: WidgetStateProperty.resolveWith(
          (states) => mainFont,
        ),
      ),
    ),
    timePickerTheme: timePickerThemeDark,
    brightness: Brightness.light,
    dividerColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.black,
    hintColor: AppColors.formsHintFont,
    fontFamily: 'notosan',

    // input fields globl style
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: 17.sp,
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(196, 134, 54, 1),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      labelStyle: TextStyle(
        color: const Color.fromARGB(255, 237, 237, 237),
        fontSize: 17.sp,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
    ),
  );
  final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 2,
    ),
    primaryColor: const Color(0xFFF8F7F3),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // background (button) color
          foregroundColor: Colors.white,
          textStyle: AppStyles.elevatedButtonTitle // foreground (text) color
          ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
      displayMedium: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
      displaySmall: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
      titleLarge: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
      titleMedium: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
      titleSmall: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
      headlineLarge: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(color: Colors.black),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.blackLight
              : AppColors.blackLight,
        ),
        textStyle: WidgetStateProperty.resolveWith(
          (states) => elevatedButtonTitle,
        ),
      ),
    ),
    timePickerTheme: timePickerThemeLight,
    brightness: Brightness.light,
    dividerColor: Colors.transparent,
    scaffoldBackgroundColor: AppColors.backgroundColorLight,
    hintColor: AppColors.formsHintFont,
    fontFamily: 'notosan',

    // input fields globl style
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: 17.sp,
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(196, 134, 54, 1),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      labelStyle: TextStyle(
        color: const Color.fromARGB(255, 237, 237, 237),
        fontSize: 17.sp,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
    ),
  );
  static final timePickerThemeDark = TimePickerThemeData(
    backgroundColor: AppColors.formsBackground,
    hourMinuteShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: AppColors.gold, width: 1),
    ),
    dayPeriodBorderSide: const BorderSide(color: AppColors.gold, width: 1),
    dayPeriodColor: AppColors.formsBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: AppColors.gold, width: 1),
    ),
    dayPeriodTextColor: Colors.white,
    dayPeriodShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: AppColors.gold, width: 1),
    ),
    hourMinuteColor: WidgetStateColor.resolveWith((states) =>
        states.contains(WidgetState.selected)
            ? AppColors.gold
            : AppColors.white),
    hourMinuteTextColor: WidgetStateColor.resolveWith((states) =>
        states.contains(WidgetState.selected) ? Colors.white : AppColors.gold),
    dialHandColor: AppColors.gold,
    dialBackgroundColor: AppColors.backgroundColor,
    hourMinuteTextStyle: const TextStyle(fontSize: 20, fontFamily: 'notosan'),
    dayPeriodTextStyle: const TextStyle(fontSize: 12, fontFamily: 'notosan'),
    helpTextStyle: const TextStyle(
        fontSize: 12, color: Colors.white, fontFamily: 'notosan'),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      contentPadding: EdgeInsets.all(0),
    ),
    dialTextColor: WidgetStateColor.resolveWith((states) =>
        states.contains(WidgetState.selected) ? AppColors.gold : Colors.white),
    entryModeIconColor: AppColors.gold,
  );

  static final timePickerThemeLight = TimePickerThemeData(
    backgroundColor: AppColors.white,
    hourMinuteShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: AppColors.gold, width: 1),
    ),
    dayPeriodBorderSide: const BorderSide(color: AppColors.gold, width: 1),
    dayPeriodColor: AppColors.backgroundColorLight,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: AppColors.gold, width: 1),
    ),
    dayPeriodTextColor: AppColors.blackLight,
    dayPeriodShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: AppColors.gold, width: 1),
    ),
    hourMinuteColor: WidgetStateColor.resolveWith((states) =>
        states.contains(WidgetState.selected)
            ? AppColors.gold
            : AppColors.backgroundColorLight),
    hourMinuteTextColor: WidgetStateColor.resolveWith((states) =>
        states.contains(WidgetState.selected) ? Colors.white : AppColors.gold),
    dialHandColor: AppColors.gold,
    dialBackgroundColor: AppColors.backgroundColorLight,
    hourMinuteTextStyle: const TextStyle(fontSize: 20, fontFamily: 'notosan'),
    dayPeriodTextStyle: const TextStyle(fontSize: 12, fontFamily: 'notosan'),
    helpTextStyle: const TextStyle(fontSize: 12, fontFamily: 'notosan'),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      contentPadding: EdgeInsets.all(0),
    ),
    dialTextColor: WidgetStateColor.resolveWith((states) =>
        states.contains(WidgetState.selected)
            ? AppColors.gold
            : AppColors.blackLight),
    entryModeIconColor: AppColors.gold,
  );
}
