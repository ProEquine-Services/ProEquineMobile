// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:proequine_dev/core/constants/images/app_images.dart';
//
// import '../../../../core/constants/colors/app_colors.dart';
// import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
//
// class DashedLineWithCircles extends StatelessWidget {
//   final String type;
//   final String from;
//   final String to;
//
//   const DashedLineWithCircles({super.key, required this.type,required this.from,required this.to});
//
//   @override
//   Widget build(BuildContext context) {
//     const double circleRadius = 4.0;
//
//     return Center(
//       child: Row(
//         children: [
//           Text(
//             from,
//             style: TextStyle(
//               fontSize: 14,
//               color: AppSharedPreferences.getTheme ==
//                   'ThemeCubitMode.dark'
//                   ? AppColors.white
//                   : AppColors.backgroundColor,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           const SizedBox(width: 8,),
//           Container(
//             width: circleRadius * 2,
//             height: circleRadius * 2,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: AppColors.yellow, // Border color
//                 width: 1.0, // Border width
//               ),
//             ),
//           ),
//           DashesLine(),
//           SizedBox(
//             width: 5,
//           ),
//           type == 'Export'
//               ? SvgPicture.asset(AppIcons.shipping)
//               : Transform.rotate(
//                   angle: 3.14159265359,
//                   child: SvgPicture.asset(AppIcons.shipping)),
//           SizedBox(
//             width: 5,
//           ),
//           DashesLine(),
//           Container(
//             width: circleRadius * 2,
//             height: circleRadius * 2,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: AppColors.yellow, // Border color
//                 width: 1.0, // Border width
//               ),
//             ),
//           ),
//           const SizedBox(width: 8,),
//           Text(
//             to,
//             style: TextStyle(
//               fontSize: 14,
//               color: AppSharedPreferences.getTheme ==
//                   'ThemeCubitMode.dark'
//                   ? AppColors.white
//                   : AppColors.backgroundColor,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
//
// class DashesLine extends StatelessWidget {
//   const DashesLine({Key? key, this.height = 1, this.color = AppColors.yellow})
//       : super(key: key);
//   final double height;
//   final Color color;
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         final boxWidth = constraints.constrainWidth();
//         const dashWidth = 10.0;
//         final dashHeight = height;
//         // final dashCount = (boxWidth / (2 * dashWidth)).floor();
//         const dashCount = 5;
//         return Flex(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           direction: Axis.horizontal,
//           children: List.generate(dashCount, (_) {
//             return Row(
//               children: [
//                 SizedBox(
//                   width: dashWidth,
//                   height: dashHeight,
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(color: color),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 3,
//                 ),
//               ],
//             );
//           }),
//         );
//       },
//     );
//   }
// }
