import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine_dev/core/constants/constants.dart';
import 'package:proequine_dev/core/constants/images/app_images.dart';
import 'package:proequine_dev/core/constants/thems/app_styles.dart';
import 'package:proequine_dev/features/user/presentation/screens/interests_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';

class WelcomeBackScreen extends StatelessWidget {
  const WelcomeBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
            title: "",
            isThereBackButton: true,
            isThereChangeWithNavigate: false,
            isThereThirdOption: false),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Image.asset(AppImages.welcomeBackImage),
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Text(
                "Welcome back to the ProEquine family!",
                style: AppStyles.mainTitle2,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: RebiButton(
                  onPressed: () {
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
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppIcons.info,
                                          color: AppColors.yellow,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Confirmation',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.blackLight),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'All submitted can only be updated via support request ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.blackLight),
                                    ),
                                    const SizedBox(height: 19),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                color: AppColors.yellow,
                                                width: 1,
                                              ),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(6.5),
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              "Back",
                                              style: TextStyle(
                                                  color: AppColors.yellow),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: RebiButton(
                                                height: 38,
                                                onPressed: () async {
                                                  if (context.mounted) {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => const InterestsScreen()));
                                                  }
                                                },
                                                child: const Text(
                                                  "Confirm",
                                                  style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700),
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
                  },
                  child: const Text("Next")),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
