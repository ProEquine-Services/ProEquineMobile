// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:proequine_dev/core/constants/colors/app_colors.dart';
// import 'package:proequine_dev/core/constants/constants.dart';
// import 'package:proequine_dev/core/constants/images/app_images.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/widgets/custom_header.dart';
// import '../widgets/proequine_bank_details_widget.dart';
//
// class BankTransferProcessScreen extends StatefulWidget {
//   const BankTransferProcessScreen({super.key});
//
//   @override
//   State<BankTransferProcessScreen> createState() =>
//       _BankTransferProcessScreenState();
// }
//
// class _BankTransferProcessScreenState extends State<BankTransferProcessScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(20.h),
//         child: CustomHeader(
//           title: "Bank Transfer Process",
//           isThereBackButton: true,
//           isThereChangeWithNavigate: false,
//         ),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 border: Border.all(
//                   color: AppColors.borderColor,
//                 ),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: kPadding, vertical: 20),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         SvgPicture.asset(AppIcons.bankTransfer1),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         const Text(
//                           "Transfer to ProEuqine bank account",
//                           style: TextStyle(
//                               color: Color(0xFF6B7280),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: 'notosan'),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: VerticalDivider(
//                         width: 5,
//                         thickness: 10,
//                         color: AppColors.grey,
//                         indent: 2,
//                         endIndent: 4,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         SvgPicture.asset(AppIcons.bankTransfer2),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         const Text(
//                           "ProEquine team will confirm the transfer",
//                           style: TextStyle(
//                               color: Color(0xFF6B7280),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: 'notosan'),
//                         )
//                       ],
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: VerticalDivider(
//                         width: 5,
//                         thickness: 10,
//                         color: AppColors.grey,
//                         indent: 2,
//                         endIndent: 4,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       children: [
//                         SvgPicture.asset(AppIcons.bankTransfer3),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         const Text(
//                           "Amount will be credited to your wallet",
//                           style: TextStyle(
//                               color: Color(0xFF6B7280),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: 'notosan'),
//                         )
//                       ],
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(5.0),
//                       child: VerticalDivider(
//                         width: 5,
//                         thickness: 10,
//                         color: AppColors.grey,
//                         indent: 2,
//                         endIndent: 4,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const ProEquineBankDetailsWidget(),
//         ],
//       ),
//     );
//   }
// }
