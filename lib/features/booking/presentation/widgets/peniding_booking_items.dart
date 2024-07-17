import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';

class PendingBookingItem extends StatelessWidget {
  final String? type;
  final String? bookingId;
  final String? date;
  final String? transport;
   const PendingBookingItem({super.key,
    this.type,
    this.bookingId,
    this.date,
    this.transport
});

  @override
  Widget build(BuildContext context) {
    return Card(
      color:const  Color(0xff191919),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 14,
                  width: 14,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  type!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(bookingId!),
              ],
            ),

            const SizedBox(
              height: 7,
            ),
            Row(
              children: [
                Expanded(
                  flex: 14,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              child: SvgPicture.asset(
                                AppIcons.date,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 13,
                            child: Text(
                              date!,
                              style:const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.grey),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 11.5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SvgPicture.asset(
                              AppIcons.transportIcon,

                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 13,
                              child: Text(transport!,
                                  style: const TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 12,
                                  )))
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),

            // location

            // buttons
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
