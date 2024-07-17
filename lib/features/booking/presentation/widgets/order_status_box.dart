import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';

class OrderStatusBox extends StatelessWidget {
  final bool orderStatus;
  final String orderStatusTitle;
  final String orderStatusDescription;

  const OrderStatusBox(
      {Key? key,
      this.orderStatus = false,
      required this.orderStatusTitle,
      required this.orderStatusDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        orderStatus == false
            ? Container(
                margin: EdgeInsets.only(left: 0.8.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      orderStatus == true ? AppColors.yellow : AppColors.grey,
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 8,
                ))
            : Container(
                // margin: EdgeInsets.only(right: 2.0.w),
                child: DottedBorder(
                    borderType: BorderType.Circle,
                    color: AppColors.yellow,
                    dashPattern: const [3, 4],
                    child: Container(
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: orderStatus == true
                              ? AppColors.yellow
                              : AppColors.grey,
                        ),
                        child: const CircleAvatar(
                          backgroundColor: AppColors.yellow,
                          radius: 8,
                        ))),
              ),
        const SizedBox(
          width: 20,
        ),
        Column(
          children: [
            SizedBox(
              width: 60.0.w,
              child: Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  orderStatusTitle,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color:
                        orderStatus == true ? AppColors.yellow : AppColors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 60.0.w,
              // height: 8.0.h,
              // padding: EdgeInsets.symmetric(vertical: 2.0.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  orderStatusDescription,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color:
                        orderStatus == true ? AppColors.yellow : AppColors.grey,
                    fontSize: 12.0.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
