
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';

import '../../../core/utils/Printer.dart';

part 'theme_state.dart';

enum ThemeCubitMode { light, dark }

class ThemeCubit extends Cubit<ThemeCubitMode> {
  ThemeCubit() : super(ThemeCubitMode.light){
    // getSavedThemeMode();
  }

  // void toggleTheme() async {
  //   final currentMode = state;
  //   final newMode = currentMode == ThemeCubitMode.light ? ThemeCubitMode.dark : ThemeCubitMode.light;
  //
  //  AppSharedPreferences.setTheme=newMode.toString();
  //   emit(newMode);
  // }

  Future<void> getSavedThemeMode() async {
    final savedMode = AppSharedPreferences.getTheme;

    Print("savedMode$savedMode");

    if (savedMode=='') {
      Print("null");
      emit(ThemeCubitMode.light);
    } else {
      Print(savedMode);
      final themeMode = ThemeCubitMode.values.firstWhere((mode) => mode.toString() == savedMode);
      emit(themeMode);
    }
  }

}