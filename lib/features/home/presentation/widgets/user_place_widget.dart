import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';

class UserPlaceWidget extends StatelessWidget {
  final String placeTitle;
  final String placeDescription;
  final bool selected;

  const UserPlaceWidget({
    super.key,
    required this.placeTitle,
    required this.selected,
    required this.placeDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: selected?AppColors.yellow:AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              placeTitle,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Noto Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              placeDescription,
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 11,
                fontFamily: 'Noto Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
