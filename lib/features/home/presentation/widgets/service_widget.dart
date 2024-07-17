import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:sizer/sizer.dart';

class ServiceWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final Function? onTap;
  final bool isItDisable;

  const ServiceWidget(
      {super.key,
      this.image,
      this.title,
      this.onTap,
      this.isItDisable = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isItDisable ? () {} : onTap!();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isItDisable
              ? Stack(
                  children: [
                    Container(
                      height: 116.0,
                      width: 27.2.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: AssetImage(image!), fit: BoxFit.cover)),
                    ),
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.8,
                        child: Container(
                            decoration: BoxDecoration(
                          color: const Color(0xB2565656),
                          borderRadius: BorderRadius.circular(8),
                        )),
                      ),
                    ),
                    const Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Coming soon',
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: 'notosan',
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 116.0,
                  width: 27.2.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: AssetImage(image!), fit: BoxFit.cover)),
                ),
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
