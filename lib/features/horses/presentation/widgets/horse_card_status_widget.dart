import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';

class HorseCardStatusWidget extends StatelessWidget {
  final String title;
  final String type;

  const HorseCardStatusWidget(
      {Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.10, vertical: 1.02),
      decoration: ShapeDecoration(
        color: type == 'Pending'
            ? AppColors.unVerifiedContainer
            : type == 'Approved'
                ? AppColors.statusBackground
                : AppColors.errorToast,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.05),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: type == 'Pending'
                  ? AppColors.unVerifiedText
                  : type == 'Approved'
                      ? AppColors.statusText
                      : AppColors.red,
              fontSize: 9,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 1.50,
            ),
          ),
        ],
      ),
    );
  }
}
