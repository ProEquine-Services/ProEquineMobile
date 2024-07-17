// import 'dart:math';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:proequine/core/constants/constants.dart';
//
// import 'package:proequine/features/home/presentation/widgets/shipping_widget_item.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/widgets/custom_header.dart';
// import '../../../shipping/presentation /screens/create_export_screen.dart';
// import '../../../shipping/presentation /screens/create_import_screen.dart';
//
// class ShippingListScreen extends StatefulWidget {
//   final String type;
//
//   const ShippingListScreen({super.key, required this.type});
//
//   @override
//   State<ShippingListScreen> createState() => _ShippingListScreenState();
// }
//
// class _ShippingListScreenState extends State<ShippingListScreen> {
//   List<String> status = ['Available', 'Closed', 'Available', 'Closed'];
//   DateTime date = DateTime.now();
//
//   List<String> title = [
//     'Emirates Longines League',
//     'SERC 8th Training Show',
//     'Emirates Longines League',
//     'SERC 8th Training Show'
//   ];
//   List<String> from = ['NL', 'NL', 'SA', 'SA'];
//   List<String> to = ['AE', 'AE', 'AE', 'AE'];
//
//   final random = Random();
//
//   @override
//   Widget build(BuildContext context) {
//     String? dateInString = date.toIso8601String();
//     DateFormat formatter = DateFormat('dd MMM yyyy');
//     final String formatted =
//     formatter.format(date);
//
// // Generate a random index to select a random item
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(20.0.h),
//         child: CustomHeader(
//           title: widget.type,
//           isThereBackButton: true,
//           isThereThirdOption: true,
//           thirdOptionTitle: "New",
//           onPressThirdOption: () {
//             if (widget.type == 'Import') {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => CreateImportScreen(
//                             isFromEditing: false,
//                           )));
//             } else {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => CreateExportScreen(
//                             isFromEditing: false,
//                           )));
//             }
//           },
//         ),
//       ),
//
//       body: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Expanded(
//               child: ListView.builder(
//                   itemCount: 5,
//                   itemBuilder: (context, index) {
//                     int randomIndex = random.nextInt(status.length);
//                     String randomStatus = status[randomIndex];
//                     String randomTitle = title[randomIndex];
//                     String randomfrom = from[randomIndex];
//                     String randomTo = to[randomIndex];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 3, horizontal: kPadding),
//                       child: ShippingWidgetItem(
//                         status: randomStatus,
//                         title: randomTitle,
//                         type: widget.type,
//                         from: randomfrom,
//                         to: randomTo,
//                         date: formatted,
//                         jobId: '12345',
//                         onTap: () {
//                           if (widget.type == "Import") {
//                             if (status[randomIndex] == 'Available') {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => CreateImportScreen(
//                                             isFromEditing: true,
//                                             importCountry: from[index],
//                                             exportCountry: "AE",
//                                         estimatedDate: date,
//                                           )));
//                             } else {}
//                           } else {
//                             if (status[randomIndex] == 'Available') {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => CreateExportScreen(
//                                             isFromEditing: true,
//                                             exportCountry: from[index],
//                                             importCountry: "AE",
//                                           )));
//                             } else {}
//                           }
//                         },
//                       ),
//                     );
//
//                     // return Container(
//                     //    color: Colors.black,
//                     //    height: 40,
//                     //    width: 90,
//                     //  );
//                   }),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//
//       // body: Column(
//       //   children: const [
//       //     SizedBox(height: 40,),
//       //     NoBooking(),
//       //   ],
//       // ),
//     );
//   }
// }
