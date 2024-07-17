import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';

import '../constants/images/app_images.dart';

class CustomErrorWidget extends StatelessWidget {
  CustomErrorWidget({
    Key? key,
    this.errorMessage,
    required this.onRetry,
    this.buttonText,
  }) : super(key: key);

   String? errorMessage;
  final Function onRetry;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 50.0,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //TODO: replace with error image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image.asset(
              AppImages.error,
              height: 18.h,
            ),
          ),
          const SizedBox(height: 40,),

          const Text(
            'Oops! Something went wrong. Please try again.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20,),

          RebiButton(
            onPressed: () {
              onRetry();
            },
            child: Text(
              buttonText ?? 'Try again'.tra,
              style: AppStyles.buttonStyle,
            ),
          ),
        ],
      ),
    );
  }
}
