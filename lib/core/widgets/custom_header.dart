import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';

import '../constants/colors/app_colors.dart';
import '../constants/constants.dart';

class CustomHeader extends StatelessWidget {
  CustomHeader({
    Key? key,
    required this.title,
    this.isThereBackButton = true,
    this.isThereChangeWithNavigate = false,
    this.thirdOptionIcon,
    this.onPressBack,
    this.onPressUp,
    this.isThereThirdOption = false,
    this.isThereThirdOptionDelete = false,
    this.isItMainScreen = false,
    this.thirdOptionTitle,
    this.onPressThirdOption,
  }) : super(key: key);

  final String title;
  final String? thirdOptionTitle;
  final bool isThereBackButton;
  final bool isItMainScreen;
  final Widget? thirdOptionIcon;
  bool isThereChangeWithNavigate = false;
  bool isThereThirdOptionDelete = false;
  bool isThereThirdOption = false;

  final Function? onPressBack;
  final Function? onPressUp;
  final Function? onPressThirdOption;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isThereBackButton
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isItMainScreen
                      ? const SizedBox()
                      : Transform(
                          // alignment: Alignment.center,
                          transform:
                              Directionality.of(context) == TextDirection.rtl
                                  ? Matrix4.rotationY(math.pi)
                                  : Matrix4.rotationY(0),
                          child: SizedBox(
                              height: 40,
                              width: 40,
                              child: GestureDetector(
                                onTap: () {
                                  isThereChangeWithNavigate
                                      ? onPressBack!()
                                      : Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back_ios_new,
                                    size: 24,
                                    color: AppSharedPreferences.getTheme ==
                                            'ThemeCubitMode.dark'
                                        ? AppColors.white
                                        : AppColors.blackLight),
                              )),
                        ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:
                          AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                              ? AppColors.white
                              : AppColors.blackLight,
                      fontSize: 17.0,
                      fontFamily: 'notosan',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  isThereThirdOption
                      ? GestureDetector(
                          onTap: () {
                            onPressThirdOption!();
                          },
                          child: thirdOptionIcon ??
                              Text(
                                thirdOptionTitle!,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: isThereThirdOptionDelete
                                      ? AppColors.red
                                      : const Color(0xFFC48636),
                                  fontSize: 14,
                                  fontFamily: 'Noto Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        )
                      : SizedBox.fromSize()
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPadding, vertical: 10),
              child: isItMainScreen
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: AppSharedPreferences.getTheme ==
                                    'ThemeCubitMode.dark'
                                ? AppColors.white
                                : AppColors.blackLight,
                            fontSize: 24.0,
                            fontFamily: 'notosan',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        isThereThirdOption
                            ? GestureDetector(
                                onTap: () {
                                  onPressThirdOption!();
                                },
                                child: Transform.translate(
                                  offset: Offset(0.0, 1),
                                  child: thirdOptionIcon ??
                                      Text(
                                        thirdOptionTitle!,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: isThereThirdOptionDelete
                                              ? AppColors.red
                                              : const Color(0xFFC48636),
                                          fontSize: 14,
                                          fontFamily: 'Noto Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                ),
                              )
                            : SizedBox.fromSize()
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: false,
                          child: Transform(
                            // alignment: Alignment.center,
                            transform:
                                Directionality.of(context) == TextDirection.rtl
                                    ? Matrix4.rotationY(math.pi)
                                    : Matrix4.rotationY(0),
                            child: GestureDetector(
                                onTap: () {
                                  isThereChangeWithNavigate
                                      ? onPressBack!()
                                      : Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back_ios_new,
                                    size: 24,
                                    color: AppSharedPreferences.getTheme ==
                                            'ThemeCubitMode.dark'
                                        ? AppColors.white
                                        : AppColors.blackLight)),
                          ),
                        ),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppSharedPreferences.getTheme ==
                                    'ThemeCubitMode.dark'
                                ? AppColors.white
                                : AppColors.blackLight,
                            fontSize: 17.0,
                            fontFamily: 'notosan',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        isThereThirdOption
                            ? GestureDetector(
                                onTap: () {
                                  onPressThirdOption!();
                                },
                                child: Transform.translate(
                                  offset: Offset(0.0, 1),
                                  child: thirdOptionIcon ??
                                      Text(
                                        thirdOptionTitle!,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: isThereThirdOptionDelete
                                              ? AppColors.red
                                              : const Color(0xFFC48636),
                                          fontSize: 14,
                                          fontFamily: 'Noto Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                ),
                              )
                            : SizedBox.fromSize()
                      ],
                    ),
            ),
    );
  }
}
