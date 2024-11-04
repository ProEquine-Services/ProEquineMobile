import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';

class UpdateShippingHeader extends StatelessWidget {
  const UpdateShippingHeader({
    super.key,
    required this.title,
    this.thirdOptionTitle,
    this.onPressThirdOption,
  });

  final String title;
  final String? thirdOptionTitle;
  final Function? onPressThirdOption;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 40,
                width: 40,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios_new,
                      size: 24, color: AppColors.blackLight),
                )),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.blackLight,
                fontSize: 17.0,
                fontFamily: 'notosan',
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () {
                onPressThirdOption!();
              },
              child: Text(
                thirdOptionTitle!,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: AppColors.red,
                  fontSize: 14,
                  fontFamily: 'Noto Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
