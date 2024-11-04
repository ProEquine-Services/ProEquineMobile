// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:proequine_dev/core/constants/colors/app_colors.dart';
// import 'package:proequine_dev/core/constants/thems/app_styles.dart';
//
// import '../../../../core/constants/images/app_images.dart';
// import '../../../../core/widgets/tracking_bottom_sheet.dart';
//
// class BookingItem extends StatelessWidget {
//   bool pending = false;
//   final String? type;
//   final String? bookingId;
//   final String? date;
//   final String? transport;
//   final String? transportType;
//   final int? horsesCount;
//
//   BookingItem({
//     super.key,
//     this.pending = false,
//     this.type,
//     this.bookingId,
//     this.date,
//     this.horsesCount,
//     this.transport,
//     this.transportType,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: AppColors.backgroundColor,
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                     Colors.black.withOpacity(0.7), BlendMode.dstATop),
//                 image: const AssetImage(
//                   AppImages.hospital,
//                 ),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         height: 14,
//                         width: 14,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: pending ? Colors.grey : AppColors.yellow),
//                       ),
//                       const SizedBox(
//                         width: 6,
//                       ),
//                       Text(
//                         type!,
//                         style: const TextStyle(
//                           color: AppColors.white,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       const Spacer(),
//                       Text(
//                         bookingId!,
//                         style: const TextStyle(
//                           color: AppColors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 7,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 14,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   flex: 1,
//                                   child: SizedBox(
//                                     child: SvgPicture.asset(
//                                       AppIcons.date,
//                                       color: AppColors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 Expanded(
//                                   flex: 13,
//                                   child: Text(
//                                     date!,
//                                     style:
//                                         const TextStyle(color: AppColors.white),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 11.5,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   flex: 1,
//                                   child: SvgPicture.asset(
//                                     AppIcons.transportIcon,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 Expanded(
//                                     flex: 13,
//                                     child: Text(transport!,
//                                         style: const TextStyle(
//                                           color: AppColors.white,
//                                         )))
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 11.5,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   flex: 1,
//                                   child: SvgPicture.asset(
//                                     AppIcons.horse,
//                                     color: AppColors.white,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 Expanded(
//                                   flex: 14,
//                                   child: Text(
//                                     horsesCount.toString(),
//                                     style:
//                                         const TextStyle(color: AppColors.white),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 11.5,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   flex: 1,
//                                   child: SvgPicture.asset(
//                                     AppIcons.transportType,
//                                     color: AppColors.white,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 Expanded(
//                                     flex: 13,
//                                     child: Text(transportType!,
//                                         style: const TextStyle(
//                                             color: AppColors.white)))
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(height: 75,),
//                           Align(
//                             alignment: Alignment.bottomRight,
//                             child: GestureDetector(
//                               onTap: (){
//                                 showTrackingBottomSheet(
//                                   context: context,
//                                   bookingId: bookingId!,
//                                   date: date!,
//                                   horsesCount: horsesCount!,
//                                   transport: transport!,
//                                   transportType: transportType!,
//                                   type: type!,
//
//                                 );
//                               },
//                               child: Container(
//                                 alignment: Alignment.bottomRight,
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 15, vertical: 6),
//                                 decoration: ShapeDecoration(
//                                   color: AppColors.yellow,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8)),
//                                 ),
//                                 child: const Text(
//                                   "Track",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w400,
//                                     fontFamily: 'notosan'
//                                   )
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
