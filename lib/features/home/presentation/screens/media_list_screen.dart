// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:proequine/core/constants/constants.dart';
// import 'package:proequine/core/constants/images/app_images.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/widgets/custom_header.dart';
// import '../widgets/show_widget_item.dart';
// import 'create_media_request_screen.dart';
//
// class MediaListScreen extends StatefulWidget {
//   String type;
//
//   MediaListScreen({super.key, required this.type});
//
//   @override
//   State<MediaListScreen> createState() => _MediaListScreenState();
// }
//
// class _MediaListScreenState extends State<MediaListScreen> {
//   List<String> images = [
//     AppImages.ba,
//     AppImages.eec,
//     AppImages.serc,
//     AppImages.eec
//   ];
//   List<String> status = [
//     'Available',
//     'Fully Booked',
//     'Available',
//     'Fully Booked'
//   ];
//   List<String> title = [
//     'Emirates Longines League',
//     'SERC 8th Training Show',
//     'Emirates Longines League',
//     'SERC 8th Training Show'
//   ];
//   List<String> from = ['30 Sep', '01 Oct', '14 Oct', '15 Oct'];
//   List<String> to = ['30 Sep', '01 Oct', '14 Oct', '15 Oct'];
//   List<String> type = ['Training', 'National', 'CSI1*, CSIYH1*', 'National'];
//
//   final random = Random();
//
//   @override
//   Widget build(BuildContext context) {
// // Generate a random index to select a random item
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(20.0.h),
//         child: CustomHeader(
//           title: "Media Services",
//           isThereBackButton: true,
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
//                     String randomImage = images[randomIndex];
//                     String randomTitle = title[randomIndex];
//                     String randomfrom = from[randomIndex];
//                     String randomTo = to[randomIndex];
//                     String randomtype = type[randomIndex];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 3, horizontal: kPadding),
//                       child: ShowWidgetItem(
//                         status: randomStatus,
//                         title: randomTitle,
//                         type: randomtype,
//                         // image: randomImage,
//                         from: randomfrom,
//                         to: randomTo,
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                        CreateMediaRequestScreen(
//                                         type: "Media Services",
//                                         eventName: title[index],
//                                       )));
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
