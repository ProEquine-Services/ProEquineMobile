import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/user/presentation/screens/login_screen.dart';

import 'dart:math' as math;

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class RegistrationHeader extends StatelessWidget {
  bool isThereBackButton = false;
  bool isThereSkip = false;
  Function? onTapSkip;

  RegistrationHeader(
      {super.key,
      this.isThereBackButton = false,
      this.isThereSkip = false,
      this.onTapSkip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kPadding, vertical: kPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isThereBackButton
              ? Transform(
                  // alignment: Alignment.center,
                  transform: Directionality.of(context) == TextDirection.rtl
                      ? Matrix4.rotationY(math.pi)
                      : Matrix4.rotationY(0),
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppSharedPreferences.getTheme ==
                                  'ThemeCubitMode.dark'
                              ? AppColors.white
                              : AppColors.backgroundColor,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )),
                )
              : Container(),
          SvgPicture.asset(
            AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                ? AppIcons.proEquine
                : AppIcons.proEquineLight,
            height: 25,
          ),
          Transform.translate(
            offset: const Offset(0.0, -2.5),
            child: TextButton(
              child: Text(
                isThereSkip ? "Skip" : "Sign In",
                style: const TextStyle(
                  color: AppColors.yellow,
                ),
              ),
              onPressed: () {
                if (isThereSkip) {
                  onTapSkip!();
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
