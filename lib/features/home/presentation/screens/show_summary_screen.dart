import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/home/data/join_show_request_model.dart';
import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';

class ShowSummaryScreen extends StatelessWidget {
  final JoinShowTransportRequestModel? joinShowTransportRequestModel;

  const ShowSummaryScreen({super.key, this.joinShowTransportRequestModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Summary",
          isThereBackButton: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 14,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFFDFD9C9)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 3, vertical: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Service",
                          style: AppStyles.summaryTitleStyle,
                        ),
                        Text(
                          "${joinShowTransportRequestModel!.trip} • ${joinShowTransportRequestModel!.tripType}",
                          style: AppStyles.summaryDesStyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${joinShowTransportRequestModel!.showingDate} • ${joinShowTransportRequestModel!.pickupTime}",
                          style: AppStyles.summaryDesStyle,
                        ),
                      ],
                    ),
                    const CustomDivider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pick up",
                          style: AppStyles.summaryTitleStyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          joinShowTransportRequestModel!.pickupLocation,
                          style: AppStyles.summaryDesStyle,
                        ),
                        Text(
                          "${joinShowTransportRequestModel!.pickupContactName} • ${joinShowTransportRequestModel!.pickupContactNumber}",
                          style: AppStyles.summaryDesStyle,
                        ),
                      ],
                    ),
                    const CustomDivider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Horses",
                          style: AppStyles.summaryTitleStyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          joinShowTransportRequestModel!.horsesNumber,
                          style: AppStyles.summaryDesStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            RebiButton(
                //
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavigation(
                              selectedIndex: 1,
                            )),
                  );
                },
                child:  Text("Close", style: AppStyles.buttonStyle,)),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
