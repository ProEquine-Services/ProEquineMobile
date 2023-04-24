import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../widgets/order_status_box.dart';
import '../widgets/order_tracking_dots.dart';

class BookingTrack extends StatelessWidget {
  String? image;
  String? type;
  final String? bookingId;
  String? date;
  String? transport;
  String? transportType;
  int? horsesCount;

  BookingTrack({
    Key? key,
    this.image,
    this.type,
    this.bookingId,
    this.date,
    this.horsesCount,
    this.transport,
    this.transportType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 40.0.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff000000),
                      image: DecorationImage(
                        image: AssetImage(image!),
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.45), BlendMode.dstATop),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 50),
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.formsBackground,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: AppColors.white,
                                  ),
                                )),
                          ),
                           Text(
                            "Transport Tracking",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'notosan',
                                fontSize: 18.0.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  color:AppColors.grey,
                                  padding: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
                                  child: Text(
                                    type!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
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
                                  flex: 13,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: SizedBox(
                                              child: SvgPicture.asset(
                                                AppIcons.date,
                                                color: AppColors.eventText,
                                                height: 30,
                                                width: 20,
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
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.eventText),
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
                                            flex: 2,
                                            child: Container(
                                              child: Image.asset(
                                                AppImages.greyTrans,
                                                scale: 2,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              flex: 13,
                                              child: Text(transport!,
                                                  style: const TextStyle(
                                                    color: AppColors.eventText,
                                                    fontSize: 14,
                                                  )))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 11.5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: SvgPicture.asset(
                                                AppIcons.horse,
                                                color: AppColors.eventText,
                                                height: 20,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 14,
                                            child: Text(
                                              horsesCount.toString(),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.eventText),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 11.5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: SvgPicture.asset(
                                                AppIcons.transportType,
                                                height: 20,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              flex: 13,
                                              child: Text(transportType!,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          AppColors.eventText)))
                                        ],
                                      )
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
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Text("Detail Status",textAlign:TextAlign.start,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18.sp),),
              ),
              SizedBox(height: 10,),
              ListView(
                shrinkWrap: true,
                primary: false,
                // padding:
                // EdgeInsets.symmetric(horizontal: 2.5.h, vertical: 5.0.h),
                children: [
                  const OrderStatusBox(
                    orderStatus: false,
                    orderStatusTitle: "Completed",
                    orderStatusDescription: "Nov 7, 2023 - 04:30",
                  ),
                  Transform.translate(
                    offset: const Offset(0.0,-20),
                    child: const OrderTrackingDots(
                        isPassed: false,),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0,-40),child:OrderStatusBox(
                    orderStatus: false,
                    orderStatusTitle: 'Delivered',
                    orderStatusDescription: 'Nov 7, 2023 - 04:30',
                  ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0,-60),child:OrderTrackingDots(
                    isPassed: true,
                  ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0,-80),child:OrderStatusBox(
                    orderStatus: true,
                    orderStatusTitle: "Reached to drop off",
                    orderStatusDescription: 'Nov 7, 2023 - 04:30, DPEC',
                  ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0,-100),child: OrderTrackingDots(
                    isPassed: true,
                  ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0,-120),child:OrderStatusBox(
                    orderStatus: true,
                    orderStatusTitle: 'On the route ',
                    orderStatusDescription: 'Nov 7, 2023 - 04:30',
                  ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0,-140),child: OrderTrackingDots(
                    isPassed: true,
                  ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0,-160),child:OrderStatusBox(
                    orderStatus: true,
                    orderStatusTitle: 'Loading',
                    orderStatusDescription: 'Nov 7, 2023 - 04:30, SERC',
                  ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0,-180),child: OrderTrackingDots(
                    isPassed: true,
                  ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0,-200),child:OrderStatusBox(
                    orderStatus: true,
                    orderStatusTitle: 'Waiting at your location ',
                    orderStatusDescription: 'Nov 7, 2023 - 04:30, SERC',
                  ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0,-220),child: OrderTrackingDots(
                    isPassed: true,
                  ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0,-240),child:OrderStatusBox(
                    orderStatus: true,
                    orderStatusTitle: 'On the route',
                    orderStatusDescription: 'Nov 7, 2023 - 04:30',
                  ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
