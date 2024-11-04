import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/widgets/shimmer.dart';

class TransactionsLoadingWidget extends StatelessWidget {
  const TransactionsLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        // shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Shimmer(
            child: Column(
              children: [
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 12,
                          width: 40,
                          child: ShimmerLoading(
                            isLoading: true,
                            child: Container(
                              height: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        SizedBox(
                          height: 8,
                          width: 60,
                          child: ShimmerLoading(
                            isLoading: true,
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                      width: 40,
                      child: ShimmerLoading(
                        isLoading: true,
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
              ],
            ),
          );
        });
  }
}
