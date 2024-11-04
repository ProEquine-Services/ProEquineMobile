import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';

class UnAvailableWalletWidget extends StatelessWidget {
  final num amount;

  const UnAvailableWalletWidget({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color(0xFFFDE4E4),
                      borderRadius: BorderRadius.circular(16)),
                  child: const Center(
                    child: Text(
                      'Insufficient',
                      style: TextStyle(
                        color: Color(0xFFF46A6A),
                        fontSize: 12,
                        fontFamily: 'Noto Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$amount AED',
                  style: const TextStyle(
                    color: AppColors.yellow,
                    fontSize: 12,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text('Top up',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColors.yellow,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
