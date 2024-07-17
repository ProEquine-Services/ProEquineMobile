import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:sizer/sizer.dart';

class EmptyLocalTransportWidget extends StatelessWidget {
  final String type;

  const EmptyLocalTransportWidget({Key? key, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 120,
          ),
          Center(
            child: type == 'shipping'
                ? SvgPicture.asset(AppIcons.emptyShipping)
                : SvgPicture.asset(AppIcons.emptyTransport),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: Text(
              type == 'shipping'
                  ? "Fly better, Fly with ProEquine ..."
                  : "Looks like you don’t have any transport ...",
              style: const TextStyle(
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: Row(
              children: [
                SvgPicture.asset(AppIcons.downArrow),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Explore our Services',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 10.00,
                    fontFamily: 'notosan',
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
