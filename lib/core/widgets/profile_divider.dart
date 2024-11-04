import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.borderColor,
      thickness: 2,
      height: 20,
      indent: 20.0,
      endIndent: 20.0,
    );
  }
}
