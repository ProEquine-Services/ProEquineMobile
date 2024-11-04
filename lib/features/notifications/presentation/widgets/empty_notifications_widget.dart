import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine_dev/core/constants/images/app_images.dart';
import 'package:sizer/sizer.dart';

class EmptyNotificationsWidget extends StatelessWidget {
  const EmptyNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 250,
        ),
        Center(
          child: SvgPicture.asset(AppIcons.emptyNotificationsIcon),
        ),
        const SizedBox(
          height: 10,
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          child: const Text(
           "No new notifications at the moment",
            style: TextStyle(
              color: Color(0xFF232F39),
              fontWeight: FontWeight.w400,
              fontFamily: 'notosan',
              fontSize: 24.26,
            ),
          ),
        ),
        const SizedBox(
          height: 120,
        ),
      ],
    );
  }
}
