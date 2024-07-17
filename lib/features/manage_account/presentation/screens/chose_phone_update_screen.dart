// import 'package:flutter/material.dart';
//
// import 'package:proequine/core/constants/constants.dart';
// import 'package:proequine/core/constants/thems/app_styles.dart';
// import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';
// import 'package:proequine/features/manage_account/presentation/screens/update_secondary_phone_number.dart';
//
//
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/constants/routes/routes.dart';
// import '../../../../core/widgets/custom_header.dart';
// import '../../../../core/widgets/profile_list_tile_widget.dart';
// import '../../../../core/widgets/profile_two_lines_list_tile.dart';
//
// class ChoseUpdatePhoneScreen extends StatefulWidget {
//   String? mainPhoneNumber;
//   // List<SecondaryPhoneNumbers>? secondaryNumbers;
//
//   ChoseUpdatePhoneScreen(
//       {super.key, this.mainPhoneNumber});
//
//   @override
//   State<ChoseUpdatePhoneScreen> createState() => _ChoseUpdatePhoneScreenState();
// }
//
// class _ChoseUpdatePhoneScreenState extends State<ChoseUpdatePhoneScreen> {
//   ManageAccountCubit cubit = ManageAccountCubit();
//
//   @override
//   void dispose() {
//     cubit.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final themeCubit = ThemeCubitProvider.of(context);
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(20.h),
//         child: CustomHeader(
//           title: "Phone",
//           isThereBackButton: true,
//           isThereChangeWithNavigate: false,
//           isThereThirdOption: true,
//           thirdOptionTitle: 'Add',
//           onPressThirdOption: () {
//             Navigator.pushNamed(context, addSecondaryPhone);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(kPadding),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 14),
//                 child: Text(
//                   "Main",
//                   style: AppStyles.profileTitles,
//                   textAlign: TextAlign.start,
//                 ),
//               ),
//               ProfileListTileWidget(
//                 title: widget.mainPhoneNumber,
//                 onTap: () {
//                   Navigator.pushNamed(context, updatePhone);
//                 },
//                 notificationList: false,
//                 isThereNewNotification: false,
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Visibility(
//                 visible: widget.secondaryNumbers!.isNotEmpty ? true : false,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 14),
//                       child: Text(
//                         "Secondary Number",
//                         style: AppStyles.profileTitles,
//                         textAlign: TextAlign.start,
//                       ),
//                     ),
//                     ListView.builder(
//                         itemCount: widget.secondaryNumbers!.length,
//                         shrinkWrap: true,
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return ProfileTwoLineListTile(
//                             title: widget.secondaryNumbers![index].title,
//                             subTitle:
//                                 widget.secondaryNumbers![index].phoneNumber,
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           UpdateSecondaryPhoneScreen(
//                                             type: widget
//                                                 .secondaryNumbers![index]
//                                                 .title!,
//                                             phoneNumber: widget
//                                                 .secondaryNumbers![index]
//                                                 .phoneNumber!,
//                                           )));
//                             },
//                             ableToEdit: true,
//                           );
//                         })
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
