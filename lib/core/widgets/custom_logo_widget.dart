import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../constants/images/app_images.dart';
import '../utils/sharedpreferences/SharedPreferencesHelper.dart';

class CustomLogoWidget extends StatelessWidget {
  const CustomLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18.h,
      child: SvgPicture.asset(
        AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
            ? AppIcons.logoDarkMode
            : AppIcons.logoLight,
      ),
    );
  }
}
