// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:proequine/core/utils/Printer.dart';
// import 'package:proequine/features/home/domain/cubits/local_horse_cubit.dart';
// import 'package:proequine/features/home/domain/repo/local_storage_repository.dart';
// import 'package:proequine/features/transports/presentation/screens/edit_trip_screen.dart';
//
// import '../../../../../core/constants/colors/app_colors.dart';
// import '../../../../../core/constants/constants.dart';
// import '../../../../../core/constants/images/app_images.dart';
// import '../../../../core/constants/thems/app_styles.dart';
// import '../../../../core/utils/rebi_message.dart';
// import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
// import '../../../../core/widgets/loading_widget.dart';
// import '../../../home/data/local_trip.dart';
//
// class DraftListItem extends StatefulWidget {
//   const DraftListItem({Key? key, required this.items}) : super(key: key);
//
//   final List<Trip> items;
//
//   @override
//   State<DraftListItem> createState() => _DraftListItemState();
// }
//
// class _DraftListItemState extends State<DraftListItem> {
//   LocalHorseCubit cubit =
//   LocalHorseCubit(localStorageRepository: LocalStorageRepository());
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: widget.items.length > 1
//           ? 225
//           : widget.items.isEmpty
//           ? 0
//           : 110,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 0),
//         child: ListView.separated(
//           itemBuilder: (context, index) {
//             Trip item = widget.items[index];
//             return GestureDetector(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>EditTripScreen(trip: item)));
//               },
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 color:
//                 AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
//                     ? const Color.fromRGBO(12, 12, 12, 1)
//                     : Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             height: 14,
//                             width: 14,
//                             decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: AppColors.formsHintFontLight),
//                           ),
//                           const SizedBox(
//                             width: 6,
//                           ),
//                           Text(
//                             "Draft",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: AppSharedPreferences.getTheme ==
//                                   'ThemeCubitMode.dark'
//                                   ? AppColors.white
//                                   : AppColors.backgroundColor,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             height: 14,
//                             width: 14,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.transparent,
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 6,
//                           ),
//                           Text(
//                             widget.items[index].type,
//                             style: AppStyles.bookingContent,
//                           ),
//                           const Spacer(),
//                           Text(
//                             widget.items[index].shippingEstimatedDate
//                                 .toString(),
//                             style: AppStyles.bookingContent,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 height: 1,
//                                 width: 1,
//                                 decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.transparent,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 "${widget.items[index].numberOfHorses
//                                     .toString()} Horses",
//                                 style: AppStyles.bookingContent,
//                               )
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 widget.items[index].type == 'import'
//                                     ? widget.items[index].importingCountry
//                                     : "AE",
//                                 style: AppStyles.bookingContent,
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               SvgPicture.asset(
//                                 AppIcons.directArrow,
//                                 height: 20,
//                                 width: 40,
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 widget.items[index].type == 'import'
//                                     ? "AE"
//                                     : widget.items[index].exportingCountry,
//                                 style: AppStyles.bookingContent,
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: 30,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//           separatorBuilder: (context, index) =>
//           const SizedBox(
//             height: 10.0,
//           ),
//           itemCount: widget.items.length,
//         ),
//       ),
//     );
//   }
//
//   _onPressDeleteTrip(Trip trip, BuildContext context) {
//     cubit.deleteTrip(DeleteTripSuccessfully(item: trip));
//   }
// }
