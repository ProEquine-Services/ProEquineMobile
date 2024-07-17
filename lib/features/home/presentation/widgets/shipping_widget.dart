import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';

class ShippingWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final Function? onTap;

  const ShippingWidget({super.key, this.image, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack(
          //   children:  [
          //     ClipRRect(
          //       borderRadius: BorderRadius.circular(8),
          //       // Set your desired border radius here
          //       child: ColorFiltered(
          //         colorFilter: ColorFilter.mode(
          //             Colors.black.withOpacity(0.6), BlendMode.darken),
          //         child:
      Container(
                    height: 22.75.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      image!,
                      width: 42.16.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                // ),
              // ),
              //  const Positioned.fill(
              //   child: Align(
              //  alignment: Alignment.center,child: Text(
              //     'Coming Soon ',
              //     style: TextStyle(
              //       color: AppColors.whiteLight,
              //       fontSize: 14,
              //       fontFamily: 'notosan',
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
              //  ),
          //   ],
          // ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title!,
            textAlign: TextAlign.start,
            style: const TextStyle(
                fontFamily: 'notosan',
                fontWeight: FontWeight.w400,
                fontSize: 15.0),
          )
        ],
      ),
    );
  }
}
