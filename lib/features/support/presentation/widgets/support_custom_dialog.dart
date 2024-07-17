import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/widgets/rebi_button.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/constants/thems/app_styles.dart';

void showThanksSupportDialog(
    {required BuildContext context,
    required String reference,
    required Function onPressHome}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Dialog(
            backgroundColor: AppColors.whiteLight,
            insetPadding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 19, left: 19, right: 19, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SvgPicture.asset(AppIcons.info),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Thanks for contacting us! ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackLight),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "We have received your request and one of our support team members will get back to you as soon as possible.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackLight),
                  ),

                  const SizedBox(height: 12),
                   Text(
                    "Reference Number $reference",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackLight),
                  ),
                  const SizedBox(height: 19),
                  RebiButton(
                      onPressed: () {
                      onPressHome();
                      },
                      child: Text("Submit", style: AppStyles.buttonStyle,)),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
