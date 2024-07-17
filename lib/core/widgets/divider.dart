import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10, bottom: 5),
      child: Divider(
        color: AppColors.borderColor,
        thickness: 1,
        indent: 0,
        endIndent: 0,
      ),
    );
  }
}
