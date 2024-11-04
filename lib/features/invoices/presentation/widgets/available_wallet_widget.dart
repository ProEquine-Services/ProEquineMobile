import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';

class AvailableWalletWidget extends StatelessWidget {
  final num amount;

  const AvailableWalletWidget({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: AppColors.borderColor,
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
            const Text(
              'Amount Available',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Noto Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '$amount AED',
              style: const TextStyle(
                color: AppColors.yellow,
                fontSize: 12,
                fontFamily: 'Noto Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
