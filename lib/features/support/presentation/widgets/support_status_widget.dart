import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';

class SupportStatusWidget extends StatelessWidget {
  final String title;
  final String type;

  const SupportStatusWidget({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.10, vertical: 3),
      decoration: ShapeDecoration(
        color: type == 'Pending'
            ? AppColors.unVerifiedContainer
            : type == 'In Progress'
            ? AppColors.inProgressBackground
            : Color(0xFFDFDFDF),
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
                  : type == 'In Progress'
                  ? AppColors.inProgressTitle
                  :  Color(0xFF4F4F4F),
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
