
import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';


_showDatePicker(BuildContext context,Function setValue) {
  showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      builder: (context, child) {
        return Theme(

            data: Theme.of(context).copyWith(
              textTheme: const TextTheme(
                titleMedium: TextStyle(color: Colors.white),
              ),
              colorScheme: const ColorScheme.light(
                primary: AppColors.gold, // <-- SEE HERE
                onPrimary: AppColors.white, // <-- SEE HERE
                onSurface: Colors.white,
                onSecondary: Colors.white,

                onInverseSurface: Colors.white// <-- SEE HERE
              ),
              dialogTheme: const DialogTheme(
                backgroundColor: AppColors.formsBackground,
                contentTextStyle: TextStyle(fontFamily: 'notosan',color: Colors.white),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, // button text color
                ),
              ),
            ),
            child: SizedBox(
              height: 100,
              width: 100,
              child: child!,
            ));
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2025))
      .then((value) {
 setValue(value);
  });
}

bool showDate(context,Function setValue){

_showDatePicker(context, setValue);
return true;
}