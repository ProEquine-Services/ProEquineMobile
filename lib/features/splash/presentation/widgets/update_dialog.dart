import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/widgets/rebi_button.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';

class UpdateAwsomeDialog {
  static Future<dynamic> updateDialog(
      {required BuildContext context,
      required Function onTapUpdate,
      required Function onTapIgnore,
      required bool isImportant}) {
    return showDialog(
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
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.info,
                          color: AppColors.yellow,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          isImportant
                              ? 'Update required'
                              : 'New Version Available!',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.blackLight),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   description,
                    //   style: const TextStyle(
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.w500,
                    //       color: AppColors.blackLight),
                    // ),
                    isImportant
                        ? const Text(
                            'You need to update the app to the\n latest version to continue using ProEquine.',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackLight),
                          )
                        : const Text(
                            'We have a new update!',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackLight),
                          ),
                    const SizedBox(height: 19),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              onTapIgnore();
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppColors.blackLight,
                                width: 1,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6.5),
                                ),
                              ),
                            ),
                            child: Text(
                              isImportant ? "Close" : 'Ignore',
                              style: const TextStyle(
                                  color: AppColors.blackLight,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: RebiButton(
                                height: 38,
                                onPressed: () {
                                  onTapUpdate();
                                },
                                child: const Text(
                                  "Update",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
