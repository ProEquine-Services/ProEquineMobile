import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/images/app_images.dart';

class EmptyInvoicesWidget extends StatelessWidget {

  const EmptyInvoicesWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 120,
          ),
          Center(
            child:  SvgPicture.asset(AppIcons.emptyInvoices),
          ),
           SizedBox(height: 25.0.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: const Text(
              "You are all good, there are no unpaid invoices",
              style: TextStyle(
                color: Color(0xFF232F39),
                fontWeight: FontWeight.w400,
                fontFamily: 'notosan',
                fontSize: 24.26,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 100,
          ),
        ],

    );
  }
}
