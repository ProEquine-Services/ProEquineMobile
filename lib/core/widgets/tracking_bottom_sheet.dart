// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../features/booking/presentation/widgets/order_status_box.dart';
// import '../../features/booking/presentation/widgets/order_tracking_dots.dart';
// import '../../features/home/presentation/widgets/create_trip_header.dart';
// import '../constants/colors/app_colors.dart';
// import '../constants/constants.dart';
// import '../constants/images/app_images.dart';
//
// void showTrackingBottomSheet({
//   required BuildContext context,
//   required String type,
//   required String bookingId,
//   required String date,
//   required String transport,
//   required int horsesCount,
//   required String transportType,
// }) {
//   showModalBottomSheet(
//     isScrollControlled: true,
//     backgroundColor: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
//         ? AppColors.formsBackground
//         : AppColors.white,
//     useSafeArea: false,
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//     ),
//     builder: (BuildContext context) {
//       return Wrap(children: [
//         SingleChildScrollView(
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height * 0.80,
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   top: kPadding, left: kPadding, right: kPadding),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Center(
//                         child: Text('Tracking',
//                             style: TextStyle(
//                                 fontSize: 17,
//                                 fontFamily: "notosan",
//                                 fontWeight: FontWeight.w600,
//                                 color: AppSharedPreferences.getTheme ==
//                                         'ThemeCubitMode.dark'
//                                     ? Colors.white
//                                     : AppColors.blackLight)),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           'Close',
//                           style: TextStyle(
//                               fontSize: 17,
//                               fontFamily: "notosan",
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.yellow),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: kPadding,
//                   ),
//                   Stack(
//                     children: [
//                       CreateTripHeader(
//                           isFromTracking: true,
//                           image: transport == 'Hospital'
//                               ? AppImages.hospitalTransport
//                               : AppImages.localTransport),
//                       Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   height: 14,
//                                   width: 14,
//                                   decoration: const BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: AppColors.yellow),
//                                 ),
//                                 const SizedBox(
//                                   width: 6,
//                                 ),
//                                 Text(
//                                   type,
//                                   style: const TextStyle(
//                                     color: AppColors.white,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 const Spacer(),
//                                 Text(
//                                   bookingId,
//                                   style: const TextStyle(
//                                     color: AppColors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 7,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   flex: 14,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             flex: 1,
//                                             child: SizedBox(
//                                               child: SvgPicture.asset(
//                                                 AppIcons.date,
//                                                 color: AppColors.white,
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Expanded(
//                                             flex: 13,
//                                             child: Text(
//                                               date,
//                                               style: const TextStyle(
//                                                   color: AppColors.white),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                         height: 11.5,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             flex: 1,
//                                             child: SvgPicture.asset(
//                                               AppIcons.transportIcon,
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Expanded(
//                                               flex: 13,
//                                               child: Text(transport,
//                                                   style: const TextStyle(
//                                                     color: AppColors.white,
//                                                   )))
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                         height: 11.5,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             flex: 1,
//                                             child: SvgPicture.asset(
//                                               AppIcons.horse,
//                                               color: AppColors.white,
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Expanded(
//                                             flex: 14,
//                                             child: Text(
//                                               horsesCount.toString(),
//                                               style: const TextStyle(
//                                                   color: AppColors.white),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                         height: 11.5,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             flex: 1,
//                                             child: SvgPicture.asset(
//                                               AppIcons.transportType,
//                                               color: AppColors.white,
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Expanded(
//                                               flex: 13,
//                                               child: Text(transportType,
//                                                   style: const TextStyle(
//                                                       color: AppColors.white)))
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 8,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     "Updates",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                         // color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 18.sp),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   ListView(
//                     shrinkWrap: true,
//                     primary: false,
//                     children: [
//                       const OrderStatusBox(
//                         orderStatus: false,
//                         orderStatusTitle: "On the route",
//                         orderStatusDescription: "Nov 7, 2023 - 04:30",
//                       ),
//                       Transform.translate(
//                         offset: const Offset(0.0, -20),
//                         child: const OrderTrackingDots(
//                           isPassed: false,
//                         ),
//                       ),
//                       Transform.translate(
//                         offset: const Offset(0.0, -40),
//                         child: const OrderStatusBox(
//                           orderStatus: false,
//                           orderStatusTitle: 'Delivered',
//                           orderStatusDescription: 'Nov 7, 2023 - 04:30',
//                         ),
//                       ),
//                       Transform.translate(
//                         offset: const Offset(0.0, -60),
//                         child: const OrderTrackingDots(
//                           isPassed: true,
//                         ),
//                       ),
//                       Transform.translate(
//                         offset: const Offset(0.0, -80),
//                         child: const OrderStatusBox(
//                           orderStatus: true,
//                           orderStatusTitle: "Reached to drop off",
//                           orderStatusDescription: 'Nov 7, 2023 - 04:30, DPEC',
//                         ),
//                       ),
//                       // Transform.translate(
//                       //   offset: const Offset(0.0, -100),
//                       //   child: const OrderTrackingDots(
//                       //     isPassed: true,
//                       //   ),
//                       // ),
//                       // Transform.translate(
//                       //   offset: const Offset(0.0, -120),
//                       //   child: const OrderStatusBox(
//                       //     orderStatus: true,
//                       //     orderStatusTitle: 'On the route ',
//                       //     orderStatusDescription: 'Nov 7, 2023 - 04:30',
//                       //   ),
//                       // ),
//                       Transform.translate(
//                         offset: const Offset(0.0, -100),
//                         child: const OrderTrackingDots(
//                           isPassed: true,
//                         ),
//                       ),
//                       Transform.translate(
//                         offset: const Offset(0.0, -120),
//                         child: const OrderStatusBox(
//                           orderStatus: true,
//                           orderStatusTitle: 'On the route',
//                           orderStatusDescription: 'Nov 7, 2023 - 04:30',
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ]);
//     },
//   );
// }
